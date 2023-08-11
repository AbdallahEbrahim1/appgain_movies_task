import 'package:appgain_movies_task/features/movie_details/bloc/bloc.dart';
import 'package:appgain_movies_task/features/movie_details/widgets/Build_description.dart';
import 'package:appgain_movies_task/features/movie_details/widgets/build_date_and_rating.dart';
import 'package:appgain_movies_task/features/movie_details/widgets/build_image.dart';
import 'package:appgain_movies_task/features/movie_details/widgets/build_share_button.dart';
import 'package:appgain_movies_task/features/movie_details/widgets/build_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailsViewBody extends StatelessWidget {
  final MoviesDetailsBloc moviesDetailsBloc;

  const MovieDetailsViewBody({Key? key, required this.moviesDetailsBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: moviesDetailsBloc,
      builder: (context, state) {
        if (state is GetMoviesDetailsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetMoviesDetailsSuccessState) {
          final model = state.data;
          return SafeArea(
            top: false,
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  BuildImage(image: model.backdropPath),
                  BuildTitle(title: model.title),
                  const SizedBox(height: 8.0),
                  BuildDateAndRating(
                    releaseDate: model.releaseDate,
                    voteAverage: model.voteAverage,
                  ),
                  const BuildShareButton(),
                  BuildDescription(description: model.overview),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
