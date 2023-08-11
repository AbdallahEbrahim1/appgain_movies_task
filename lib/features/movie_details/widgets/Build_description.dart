import 'package:flutter/material.dart';

class BuildDescription extends StatelessWidget {
  final String description;
  const BuildDescription({Key? key, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Text(
        description,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
