import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tweet_app/src/features/tweet/services/cloud_storage_repository_firebase.dart';
import 'package:tweet_app/src/core/services/fetch_local_image_service.dart';
import 'package:tweet_app/src/features/tweet/services/random_generator_id_service.dart';
import 'package:tweet_app/src/features/tweet/submodules/add_tweet/store/add_tweet_store.dart';

import 'package:uuid/uuid.dart';

import '../../services/tweet_repository_firestore.dart';
import '../../../../core/services/auth_service_firebase.dart';
import 'add_tweet_screen.dart';

class AddTweetModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton(
            (i) => RandomGeneratorIdService(generator: const Uuid())),
        Bind.lazySingleton(
          (i) => AddTweetStore(
            tweetRepository: i<TweetRepositoryFirestore>(),
            userUid: i<AuthServiceFirebase>().getCurrentUserUid()!,
            storageRepository: i<CloudStorageRepositoryFirebase>(),
            imageService: i<FetchLocalImageService>(),
            generator: i<RandomGeneratorIdService>(),
          ),
        ),
        Bind.singleton((i) => FetchLocalImageService(picker: ImagePicker())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const AddTweetScreen()),
      ];
}
