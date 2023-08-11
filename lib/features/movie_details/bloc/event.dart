part of 'bloc.dart';

class MoviesDetailsEvents {}

class GetMoviesDetailsEvent extends MoviesDetailsEvents {
  final int id;

  GetMoviesDetailsEvent({required this.id});
}
