import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/features/config/services/logout_service.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  late final LogoutService logoutService;

  @override
  void initState() {
    logoutService = Modular.get<LogoutService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurations Page'),
      ),
      body: Column(
        children: [
          const Icon(
            Icons.settings,
            size: 100,
          ),
          const Text(
            'Configurations',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          const ListTile(
            title: Text('Account'),
            leading: Icon(Icons.person, size: 30),
          ),
          const ListTile(
            leading: Icon(Icons.settings_applications, size: 30),
            title: Text('App Details'),
          ),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout, size: 30),
            onTap: () {
              logoutService.logoutUser().then((value) {
                Modular.to.navigate('../auth');
              });
            },
          )
        ],
      ),
    );
  }
}
