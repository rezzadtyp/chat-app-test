import 'package:chat_app_test/firebase_options.dart';
import 'package:chat_app_test/injectable.dart';
import 'package:chat_app_test/presentation/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();
  runApp(const App());
}
