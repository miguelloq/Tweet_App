import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/firebase_options.dart';
import 'package:tweet_app/src/app_module.dart';
import 'package:tweet_app/src/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
