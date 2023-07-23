import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:tweet_app/src/features/tweet/submodules/add_tweet/store/add_tweet_store.dart';

import 'components/custom_icon_button.dart';
import 'components/custom_image_file.dart';

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
            'Error: ${addTweetStore.errorText}',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
        addTweetStore.newScreenState(newState: AddTweetState.waiting);
      }
    });
    when((_) => addTweetStore.addTweetState == AddTweetState.success, () {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Success in creating the tweet',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ));
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
      body: ListView(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
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
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomIconButton(
                buttonFuncion: () {
                  addTweetStore.pickAndChooseImageGallery();
                },
                iconSymbol: Icons.image,
              ),
              CustomIconButton(
                buttonFuncion: () {
                  addTweetStore.pickAndChooseImageCamera();
                },
                iconSymbol: Icons.camera_alt_outlined,
              ),
              CustomIconButton(
                buttonFuncion: () {},
                iconSymbol: Icons.voice_chat,
              ),
              CustomIconButton(
                buttonFuncion: () {},
                iconSymbol: Icons.notifications_active,
              ),
            ],
          ),
          const Divider(
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Observer(
              builder: (_) => Wrap(
                alignment: WrapAlignment.start,
                children: addTweetStore.chosenImages
                    .map(
                      (data) => Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: CustomImageFile(
                          height: 125,
                          width: 125,
                          chosenFile: data.file,
                          iconButtonFunction: () {
                            addTweetStore.removeImageInChosenImages(
                              position:
                                  addTweetStore.chosenImages.indexOf(data),
                            );
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
