import 'package:flutter/material.dart';

class BuildImage extends StatelessWidget {
  final String image;
  const BuildImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://image.tmdb.org/t/p/w185$image",
      height: 300,
      fit: BoxFit.cover,
    );
  }
}
