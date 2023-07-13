import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  late final FirebaseAuth firebaseAuth;

  @override
  void initState() {
    firebaseAuth = FirebaseAuth.instance;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (firebaseAuth.currentUser != null) {
        Modular.to.navigate('/home');
      } else {
        Modular.to.navigate('/login');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
