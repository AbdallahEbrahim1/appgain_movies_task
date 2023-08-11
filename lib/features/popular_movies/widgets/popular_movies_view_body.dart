import 'package:appgain_movies_task/features/popular_movies/bloc/bloc.dart';
import 'package:appgain_movies_task/features/popular_movies/widgets/movies_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesViewBody extends StatelessWidget {
  final PopularBloc popularBloc;
  const PopularMoviesViewBody({Key? key, required this.popularBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: popularBloc,
      builder: (context, state) {
        if (state is GetPopularLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetPopularFailedState) {
          return Center(child: Text(state.msg));
        } else if (state is GetPopularSuccessState) {
          return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: state.data.results.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              final data = state.data.results[index];
              return MoviesItem(
                data: data,
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
