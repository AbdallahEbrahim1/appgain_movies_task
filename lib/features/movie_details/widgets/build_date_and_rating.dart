import 'package:appgain_movies_task/features/movie_details/widgets/rating.dart';
import 'package:flutter/material.dart';

class BuildDateAndRating extends StatelessWidget {
  final String releaseDate;
  final num voteAverage;
  const BuildDateAndRating(
      {Key? key, required this.releaseDate, required this.voteAverage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(releaseDate, style: const TextStyle(fontSize: 18.0)),
          RatingWidget(voteAverage.toDouble()),
        ],
      ),
    );
  }
}
