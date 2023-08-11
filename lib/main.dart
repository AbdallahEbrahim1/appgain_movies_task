import 'package:appgain_movies_task/my_app.dart';
import 'package:appgain_movies_task/network/remote/kiwi.dart';
import 'package:appgain_movies_task/utils/dynamic_link.dart';
import 'package:appgain_movies_task/utils/firebase_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  DynamicLinksProvider().initDynamicLink();
  initKiwi();
  runApp(const MyApp());
}
