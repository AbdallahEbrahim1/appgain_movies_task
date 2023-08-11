import 'package:appgain_movies_task/features/movie_details/bloc/bloc.dart';
import 'package:appgain_movies_task/features/movie_details/widgets/movie_details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';

class MovieDetailsView extends StatefulWidget {
  final int movieId;

  const MovieDetailsView({super.key, required this.movieId});

  @override
  _MovieDetailsViewState createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  final moviesDetailsBloc = KiwiContainer().resolve<MoviesDetailsBloc>();

  @override
  void initState() {
    moviesDetailsBloc.add(GetMoviesDetailsEvent(id: widget.movieId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MovieDetailsViewBody(
        moviesDetailsBloc: moviesDetailsBloc,
      ),
    );
  }
}
