import 'package:flutter/widgets.dart';
import 'package:tweet_app/src/features/auth/login/login_screen.dart';
import 'package:tweet_app/src/features/auth/registration/registration_screen.dart';
import 'package:tweet_app/src/features/home/home_screen.dart';

import '../features/auth/check/auth_check.dart';

var customRoutes = <String, WidgetBuilder>{
  'authCheck': (context) => const AuthCheck(),
  'authLogin': (context) => const LoginScreen(),
  'authRegistration': (context) => const RegistrationScreen(),
  'home': (context) => const HomeScreen(),
};
