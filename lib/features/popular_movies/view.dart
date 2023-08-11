import 'package:appgain_movies_task/features/popular_movies/bloc/bloc.dart';
import 'package:appgain_movies_task/features/popular_movies/widgets/popular_movies_view_body.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';

class PopularMoviesView extends StatefulWidget {
  const PopularMoviesView({Key? key}) : super(key: key);

  @override
  State<PopularMoviesView> createState() => _PopularMoviesViewState();
}

class _PopularMoviesViewState extends State<PopularMoviesView> {
  final popularBloc = KiwiContainer().resolve<PopularBloc>();

  @override
  void initState() {
    popularBloc.add(GetPopularEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Popular Movies'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
            )
          ]),
      body: PopularMoviesViewBody(
        popularBloc: popularBloc,
      ),
    );
  }
}
