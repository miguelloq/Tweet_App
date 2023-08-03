import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/features/config/services/logout_service.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  final instanceAuth = Modular.get<FirebaseAuth>();
  final logoutService = Modular.get<LogoutService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurations Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('${instanceAuth.currentUser!.email}'),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                logoutService.logoutUser().then((value) {
                  Modular.to.navigate('../auth');
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
