part of 'bloc.dart';

class PopularStates {}

class GetPopularLoadingState extends PopularStates {}

class GetPopularSuccessState extends PopularStates {
  PopularModel data;
  String msg;

  GetPopularSuccessState({
    required this.msg,
    required this.data,
  });
}

class GetPopularFailedState extends PopularStates {
  String msg;

  GetPopularFailedState({required this.msg});
}
