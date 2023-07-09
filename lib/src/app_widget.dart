import 'package:flutter/material.dart';
import 'package:tweet_app/src/routes/custom_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tweet App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo,
        brightness: Brightness.light,
      ),
      routes: customRoutes,
      initialRoute: 'authCheck',
    );
  }
}
