import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String uidOwnerProfile;
  final String uidVisitor;
  const ProfileScreen(
      {super.key, required this.uidOwnerProfile, required this.uidVisitor});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('a'),
      ),
      body: Placeholder(),
    );
  }
}
