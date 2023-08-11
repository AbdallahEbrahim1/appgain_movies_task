import 'package:appgain_movies_task/network/remote/server_gate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model.dart';

part 'event.dart';
part 'states.dart';

class PopularBloc extends Bloc<PopularEvents, PopularStates> {
  final ServerGate dio;
  final _apiKey = 'd9e3e0ba90cbda2598c737da35a4586a';
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  PopularBloc(this.dio) : super(PopularStates()) {
    on<GetPopularEvent>(_getPopular);
  }

  Future _getPopular(GetPopularEvent event, Emitter<PopularStates> emit) async {
    emit(GetPopularLoadingState());

    final response = await dio.getFromServer(
      url: "$_baseUrl/popular?api_key=$_apiKey",
      // url: "ApiNames.getPopular",
      headers: {
        'Authorization': 'Bearer ',
      },
    );
    if (response.success) {
      final model = PopularModel.fromJson(response.response!.data);
      emit(
        GetPopularSuccessState(msg: response.msg, data: model),
      );
    } else {
      emit(
        GetPopularFailedState(
          msg: response.msg,
        ),
      );
    }
  }
}
