import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:tweet_app/src/features/tweet/store/drawer_store.dart';
import 'package:tweet_app/src/features/tweet/ui/components/mini_profile_information.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final DrawerStore drawerStore = Modular.get();

  @override
  void initState() {
    super.initState();
    drawerStore.loadInformation();
    autorun((_) {
      if (drawerStore.screenState == DrawerScreenState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error: ${drawerStore.errorMessage}',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Observer(
              builder: (_) => drawerStore.screenState ==
                      DrawerScreenState.loaded
                  ? MiniProfileInformation(
                      profileImage: Image.network(drawerStore.user.iconPhoto),
                      followersAmount: drawerStore.followersAmount,
                      followingAmount: drawerStore.followingAmount,
                      identifier: drawerStore.user.identifier)
                  : const CircularProgressIndicator(),
            ),
            Expanded(
              child: ListView(
                children: [
                  const Divider(
                    thickness: 1.5,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.insert_emoticon_outlined,
                    ),
                    title: const Text('Profile'),
                    onTap: () {
                      Modular.to.pop();
                      Modular.to
                          .pushNamed('profile/${drawerStore.returnUidAuth()}');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Configurations'),
                    onTap: () {
                      Modular.to.pop();
                      Modular.to.pushNamed('/config/');
                    },
                  ),
                  const Divider(
                    thickness: 1.5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildProfileInformation() => Container();
