import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';

class DynamicLinksProvider {
  /// create the link
  Future<String> createLink(String refCode) async {
    final String url = "https://com.example.appgain_movies_task?ref=$refCode";

    final DynamicLinkParameters parameters = DynamicLinkParameters(
        androidParameters: const AndroidParameters(
          packageName: "com.example.appgain_movies_task",
          minimumVersion: 0,
        ),
        iosParameters: const IOSParameters(
          bundleId: "com.example.appgain_movies_task",
          minimumVersion: "0",
        ),
        link: Uri.parse(url),
        uriPrefix: "https://appgainmoviestask.page.link");
    final FirebaseDynamicLinks links = FirebaseDynamicLinks.instance;
    final refLink = await links.buildShortLink(parameters);
    return refLink.shortUrl.toString();
  }

  ///init Dynamic Link
  void initDynamicLink() async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();

    if (instanceLink != null) {
      final Uri refLink = instanceLink.link;
      Share.share("this is the link ${refLink.queryParameters["ref"]}");
    }
  }
}
