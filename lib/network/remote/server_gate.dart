import 'dart:async';
import 'dart:convert';

import 'package:appgain_movies_task/network/remote/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ServerGate {
  static final i = ServerGate._();
  final _dio = Dio();
  final LoggerDebug log =
      LoggerDebug(headColor: LogColors.red, constTitle: "Server Gate Logger");

  ServerGate._() {
    addInterceptors();
  }

  CancelToken cancelToken = CancelToken();

  Map<String, dynamic> _header() {
    return {
      // "Authorization": UserModel.instance.tokenWithType,
      "Accept": "application/json",
      // "Accept-Language": LocaleKeys.lang.tr(),
      // "lang": LocaleKeys.lang.tr(),
    };
  }

  void addInterceptors() {
    _dio.interceptors.add(CustomApiInterceptor(log));
  }

  T objectFromJson<T>(T Function(dynamic) callback, Response response,
      {String? attribute}) {
    try {
      if (response.data != null) {
        if (attribute == "") return callback(response.data);
        if (response.data[attribute ?? "data"] != null) {
          return callback(response.data[attribute ?? "data"]);
        }
      }
      return callback(T is List ? <T>[] : <String, dynamic>{});
    } catch (e) {
      response.data = {
        "message": kDebugMode ? e.toString() : "sorry_Something_went_wrong"
      };
      response.statusCode = 500;
      log.red("\x1B[37m------ Current Error Response -----\x1B[0m");
      log.red("\x1B[31m${response.data}\x1B[0m");
      throw DioError(
        requestOptions: response.requestOptions,
        response: response,
        type: DioErrorType.response,
      );
    }
  }

  // ------ GET DATA FROM SERVER -------//
  Future<CustomResponse<T>> getFromServer<T>(
      {required String url,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? params,
      T Function(dynamic)? callback,
      String? attribute,
      bool withoutHeader = false}) async {
    // add stander header
    if (!withoutHeader) {
      if (headers != null) {
        if (!withoutHeader) headers.addAll(_header());
        headers.removeWhere((key, value) => value == null || value == "");
      } else {
        if (!withoutHeader) headers = _header();
      }
    }
    // remove nulls from params
    if (params != null) {
      params.removeWhere(
          (key, value) => params[key] == null || params[key] == "");
    }

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: headers,
          sendTimeout: 5000,
          receiveTimeout: 5000,
        ),
        queryParameters: params,
      );

      return CustomResponse<T>(
        success: true,
        statusCode: 200,
        errType: null,
        msg: (response.data["message"] ?? "Your request completed succesfully")
            .toString(),
        response: response,
        data: callback == null
            ? null
            : objectFromJson<T>(callback, response, attribute: attribute),
      );
    } on DioError catch (err) {
      return handleServerError(err);
    }
  }

  // -------- HANDLE ERROR ---------//
  CustomResponse<T> handleServerError<T>(DioError err) {
    if (err.type == DioErrorType.response) {
      if (err.response!.data.toString().contains("DOCTYPE") ||
          err.response!.data.toString().contains("<script>") ||
          err.response!.data["exception"] != null) {
        return CustomResponse(
          success: false,
          errType: 1,
          statusCode: err.response!.statusCode ?? 500,
          msg: kDebugMode
              ? "${err.response!.data}"
              : "server_error_please_try_again_later",
          response: null,
        );
      }
      if (err.response!.statusCode == 401) {
        return CustomResponse(
          success: false,
          statusCode: err.response?.statusCode ?? 401,
          errType: 3,
          msg: err.response?.data["message"] ?? '',
          response: err.response,
        );
      }
      try {
        return CustomResponse(
          success: false,
          statusCode: err.response?.statusCode ?? 500,
          errType: 2,
          msg: (err.response!.data["errors"] as Map).values.first.first,
          response: err.response,
        );
      } catch (e) {
        return CustomResponse(
          success: false,
          statusCode: err.response?.statusCode ?? 500,
          errType: 2,
          msg: err.response?.data["message"],
          response: err.response,
        );
      }
    } else if (err.type == DioErrorType.receiveTimeout ||
        err.type == DioErrorType.sendTimeout) {
      return CustomResponse(
        success: false,
        statusCode: err.response?.statusCode ?? 500,
        errType: 0,
        msg: "poor_connection_check_the_quality_of_the_internet",
        response: null,
      );
    } else {
      if (err.response == null) {
        return CustomResponse(
          success: false,
          statusCode: 402,
          errType: 0,
          msg: "no_connection_check_the_quality_of_the_internet",
          response: null,
        );
      }
      return CustomResponse(
        success: false,
        statusCode: 402,
        errType: 1,
        msg: err.response?.data["message"],
        response: null,
      );
    }
  }
}

class CustomApiInterceptor extends Interceptor {
  LoggerDebug log;

  CustomApiInterceptor(this.log);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log.red("\x1B[37m------ Current Error Response -----\x1B[0m");
    log.red("\x1B[31m${err.response?.data}\x1B[0m");
    return super.onError(err, handler);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    log.green("------ Current Response ------");
    log.green(jsonEncode(response.data));
    return super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log.cyan("------ Current Request Parameters Data -----");
    log.cyan("${options.queryParameters}");
    log.yellow("------ Current Request Headers -----");
    log.yellow("${options.headers}");
    log.green("------ Current Request Path -----");
    log.green(
        "${options.path} ${LogColors.red}API METHOD : (${options.method})${LogColors.reset}");
    return super.onRequest(options, handler);
  }
}

class CustomResponse<T> {
  bool success;
  int? errType;

  // 0 => network error
  // 1 => error from the server
  // 3 => unAuth
  // 2 => other error

  String msg;
  int statusCode;
  Response? response;
  T? data;

  CustomResponse({
    this.success = false,
    this.errType = 0,
    this.msg = "",
    this.statusCode = 0,
    this.response,
    this.data,
  });
}

class CustomError {
  int? type;
  String? msg;
  dynamic error;

  CustomError({
    this.type,
    this.msg,
    this.error,
  });
}
