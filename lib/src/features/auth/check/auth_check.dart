import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        Navigator.pushReplacementNamed(context, 'home');
      } else {
        Navigator.pushReplacementNamed(context, 'authLogin');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
