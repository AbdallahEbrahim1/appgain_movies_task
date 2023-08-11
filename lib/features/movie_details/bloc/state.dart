part of 'bloc.dart';

class MoviesDetailsStates {}

class GetMoviesDetailsLoadingState extends MoviesDetailsStates {}

class GetMoviesDetailsFailedState extends MoviesDetailsStates {
  String msg;

  GetMoviesDetailsFailedState({required this.msg});
}

class GetMoviesDetailsSuccessState extends MoviesDetailsStates {
  String msg;
  MoviesDetailsModel data;

  GetMoviesDetailsSuccessState({required this.data, required this.msg});
}
