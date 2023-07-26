import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/features/tweet/store/home_store.dart';
import 'package:tweet_app/src/features/tweet/submodules/feed/feed_module.dart';
import 'package:tweet_app/src/features/tweet/submodules/search/search_module.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeStore homeStore = Modular.get<HomeStore>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurations'),
              onTap: () {
                Modular.to.pop();
                Modular.to.pushNamed('../config');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed('/tweet/addTweet');
        },
        child: const Icon(Icons.add),
      ),
      body: Observer(
        builder: (_) => PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: homeStore.pageViewController,
          children: [
            FeedModule(),
            SearchModule(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Modular.to
                      .pushNamed('./profile/PgklNCiMmGcm6DTa0LkNO73sLN12');
                },
                child: const Text('Profile'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Observer(
        builder: (_) => BottomNavigationBar(
          currentIndex: homeStore.currentPage,
          onTap: (index) {
            homeStore.changeCurrentPage(index);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.list_rounded), label: 'Feed'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined),
              label: 'Chat',
            ),
          ],
        ),
      ),
    );
  }
}
