import 'package:appgain_movies_task/features/notifications/widgets/notifications_view_body.dart';
import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({Key? key}) : super(key: key);
  static const route = '/notifications-view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: const NotificationsViewBody(),
    );
  }
}
