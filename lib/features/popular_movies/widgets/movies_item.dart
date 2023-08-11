import 'package:appgain_movies_task/features/movie_details/view.dart';
import 'package:appgain_movies_task/features/popular_movies/bloc/model.dart';
import 'package:flutter/material.dart';

class MoviesItem extends StatelessWidget {
  final Results data;
  const MoviesItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          child: InkResponse(
            splashColor: Colors.red,
            enableFeedback: true,
            child: Image.network(
              "https://image.tmdb.org/t/p/w185${data.backdropPath}",
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MovieDetailsView(
                  movieId: data.id,
                );
              }));
            },
          ),
        ),
      ],
    );
  }
}
