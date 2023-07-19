import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:tweet_app/src/features/home/submodules/add_tweet/components/custom_icon_button.dart';
import 'package:tweet_app/src/features/home/submodules/add_tweet/store/add_tweet_store.dart';

class AddTweetScreen extends StatefulWidget {
  const AddTweetScreen({super.key});

  @override
  State<AddTweetScreen> createState() => _AddTweetScreenState();
}

class _AddTweetScreenState extends State<AddTweetScreen> {
  final AddTweetStore addTweetStore = Modular.get<AddTweetStore>();

  @override
  void initState() {
    super.initState();
    autorun((_) {
      if (addTweetStore.addTweetState == AddTweetState.error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Authentication error: ${addTweetStore.errorText}',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
      }
    });
    when((_) => addTweetStore.addTweetState == AddTweetState.success, () {
      Modular.to.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Modular.to.pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.extended(
                elevation: 0,
                onPressed: () {
                  addTweetStore.addTweetAction();
                },
                label: const Text('New tweet')),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.account_circle_rounded,
                    size: 45,
                  ),
                ),
                Text(
                  'Your tweet is public.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'What do you want to say to the world?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
              maxLength: 200,
              minLines: 1,
              maxLines: 10,
              style: Theme.of(context).textTheme.titleMedium,
              onChanged: (value) {
                addTweetStore.setMessage(newMessage: value);
              },
            ),
            const SizedBox(
              height: 25,
            ),
            const Divider(
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomIconButton(buttonFuncion: () {}, iconSymbol: Icons.image),
                CustomIconButton(
                    buttonFuncion: () {}, iconSymbol: Icons.gif_box_outlined),
                CustomIconButton(
                    buttonFuncion: () {},
                    iconSymbol: Icons.notifications_active),
                CustomIconButton(
                    buttonFuncion: () {}, iconSymbol: Icons.voice_chat),
              ],
            ),
            const Divider(
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}
