import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tweet_app/src/features/home/submodules/feed/store/feed_store.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed Screen'),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: ((context, index) {
          return ExampleTile(feedStore: FeedStore());
        }),
      ),
    );
  }
}

class ExampleTile extends StatelessWidget {
  final FeedStore feedStore;
  const ExampleTile({super.key, required this.feedStore});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Observer(builder: (_) => Text('${feedStore.counter}')),
      leading: IconButton(
        icon: const Icon(Icons.plus_one),
        onPressed: () {
          feedStore.incrementCounter();
        },
      ),
    );
  }
}
