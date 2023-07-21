import 'dart:io';

import 'package:mobx/mobx.dart';
import 'package:tweet_app/src/core/repositories/tweet_repository_firestore.dart';
import 'package:tweet_app/src/core/services/random_generator_id_service.dart';
import 'package:tweet_app/src/features/home/submodules/add_tweet/models/add_tweet_request_model.dart';
import 'package:tweet_app/src/features/home/submodules/add_tweet/models/image_request_model.dart';

import '../../../../../core/repositories/cloud_storage_repository_firebase.dart';
import '../../../../../core/services/fetch_local_image_service.dart';
part 'add_tweet_store.g.dart';

enum AddTweetState { success, error, waiting }

class AddTweetStore = _AddTweetStore with _$AddTweetStore;

abstract class _AddTweetStore with Store {
  final TweetRepositoryFirestore tweetRepository;
  final CloudStorageRepositoryFirebase storageRepository;
  final FetchLocalImageService imageService;
  final String userUid;
  final RandomGeneratorIdService generator;

  AddTweetRequestModel requestModel;

  _AddTweetStore({
    required this.tweetRepository,
    required this.userUid,
    required this.storageRepository,
    required this.imageService,
    required this.generator,
  }) : requestModel = AddTweetRequestModel(
          userUid: userUid,
          message: '',
        );

  @observable
  String? errorText;

  @observable
  AddTweetState addTweetState = AddTweetState.waiting;

  @observable
  List<ImageRequestModel> chosenImages = ObservableList<ImageRequestModel>();

  void setMessage({required String newMessage}) {
    requestModel = requestModel.copyWith(message: newMessage);
  }

  void pickAndChooseImageGallery() {
    imageService.getFileImageGallery().then((tuple) {
      String? fileName = tuple.$1;
      String? filePath = tuple.$2;
      if (fileName != null && filePath != null) {
        addImageInChosenImages(
            file: File(filePath), path: filePath, name: fileName);
      }
    });
  }

  void pickAndChooseImageCamera() {
    imageService.getFileImageCamera().then((tuple) {
      String? fileName = tuple.$1;
      String? filePath = tuple.$2;
      if (fileName != null && filePath != null) {
        addImageInChosenImages(
            file: File(filePath), path: filePath, name: fileName);
      }
    });
  }

  @action
  void newScreenState({required AddTweetState newState}) {
    if (addTweetState == AddTweetState.error &&
        newState != AddTweetState.error) {
      errorText = null;
    }
    addTweetState = newState;
  }

  @action
  void addImageInChosenImages(
      {required File file, required String path, required String name}) {
    ImageRequestModel newImage =
        ImageRequestModel(file: file, filePath: path, fileName: name);
    for (var image in chosenImages) {
      if (image.isSameName(otherImage: newImage)) {
        newScreenState(newState: AddTweetState.error);
        errorText = 'This photo is already selected.';
        return;
      }
    }
    chosenImages.add(newImage);
  }

  @action
  void removeImageInChosenImages({required int position}) {
    chosenImages.removeAt(position);
  }

  @action
  void addTweetAction() {
    String docNewTweetName = generator.idGeneration();

    tweetRepository
        .createTweet(
            docTweetName: docNewTweetName,
            uidAuth: requestModel.userUid,
            bodyText: requestModel.message,
            postCreationTime: DateTime.now(),
            images: chosenImages.isEmpty
                ? null
                : chosenImages.map((e) => e.fileName).toList())
        .then((value) {
      try {
        for (var image in chosenImages) {
          storageRepository.uploadImageTweet(
              uidAuth: userUid,
              tweetDocName: docNewTweetName,
              imageId: image.fileName,
              path: image.filePath);
          newScreenState(newState: AddTweetState.success);
        }
      } catch (e) {
        errorText = e.toString();
        newScreenState(newState: AddTweetState.error);
      }
    });
  }
}
