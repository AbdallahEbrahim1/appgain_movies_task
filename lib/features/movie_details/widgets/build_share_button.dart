import 'package:appgain_movies_task/utils/dynamic_link.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class BuildShareButton extends StatelessWidget {
  const BuildShareButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          DynamicLinksProvider().createLink('.........').then((value) {
            Share.share(value);
          });
        },
        child: const Chip(label: Text('Share')));
  }
}
