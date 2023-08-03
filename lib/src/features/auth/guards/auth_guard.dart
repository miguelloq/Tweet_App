import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthGuard extends RouteGuard {
  final FirebaseAuth authInstance;

  AuthGuard({required this.authInstance}) : super(redirectTo: '/tweet/');
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    return authInstance.currentUser == null ? true : false;
  }
}
