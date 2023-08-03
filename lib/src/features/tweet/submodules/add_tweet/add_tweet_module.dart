import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tweet_app/src/core/repositories/cloud_storage_repository_firebase.dart';
import 'package:tweet_app/src/core/services/device_current_user_information.dart';
import 'package:tweet_app/src/core/services/fetch_local_image_service.dart';
import 'package:tweet_app/src/features/tweet/submodules/add_tweet/services/random_generator_id_service.dart';
import 'package:tweet_app/src/features/tweet/submodules/add_tweet/services/send_tweet_service.dart';
import 'package:tweet_app/src/features/tweet/submodules/add_tweet/store/add_tweet_store.dart';

import 'package:uuid/uuid.dart';

import '../../services/tweet_repository_firestore.dart';
import 'add_tweet_screen.dart';

class AddTweetModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton(
            (i) => RandomGeneratorIdService(generator: const Uuid())),
        Bind.singleton((i) => SendTweetService(
              tweetRepository: i<TweetRepositoryFirestore>(),
              storageRepository: i<CloudStorageRepositoryFirebase>(),
              generator: i<RandomGeneratorIdService>(),
            )),
        Bind.singleton((i) => FetchLocalImageService(picker: ImagePicker())),
        Bind.lazySingleton((i) => AddTweetStore(
              userUid: i<DeviceCurrentUserInformation>().getCurrentUserUid()!,
              imageService: i<FetchLocalImageService>(),
              sendService: i<SendTweetService>(),
            )),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const AddTweetScreen()),
        ChildRoute('/comment/:commentedTweetDocName',
            child: (context, args) => AddTweetScreen(
                  commentedtweetDocName: args.params['commentedTweetDocName'],
                ))
      ];
}
