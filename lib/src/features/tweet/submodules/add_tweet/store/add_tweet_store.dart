import 'dart:io';

import 'package:mobx/mobx.dart';

import 'package:tweet_app/src/features/tweet/submodules/add_tweet/services/send_tweet_service.dart';

import '../../../../../core/services/fetch_local_image_service.dart';
import '../models/add_tweet_request_model.dart';
import '../models/image_request_model.dart';
part 'add_tweet_store.g.dart';

enum AddTweetState { success, error, waiting }

class AddTweetStore = _AddTweetStore with _$AddTweetStore;

abstract class _AddTweetStore with Store {
  final SendTweetService sendService;
  final FetchLocalImageService imageService;
  final String userUid;

  AddTweetRequestModel requestModel;

  _AddTweetStore({
    required this.userUid,
    required this.sendService,
    required this.imageService,
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
  void addTweetAction({String? commentedTweetDocName}) {
    try {
      if (commentedTweetDocName == null) {
        if (chosenImages.isEmpty) {
          sendService.sendTweet(
              bodyText: requestModel.message, uidAuth: userUid);
        } else {
          sendService.sendTweet(
              bodyText: requestModel.message,
              uidAuth: userUid,
              imageList: chosenImages);
        }
      } else {
        if (chosenImages.isEmpty) {
          sendService.sendTweetComment(
              bodyText: requestModel.message,
              uidAuth: userUid,
              commentedTweetDocName: commentedTweetDocName);
        } else {
          sendService.sendTweetComment(
              bodyText: requestModel.message,
              uidAuth: userUid,
              imageList: chosenImages,
              commentedTweetDocName: commentedTweetDocName);
        }
      }
      newScreenState(newState: AddTweetState.success);
    } catch (e) {
      errorText = e.toString();
      newScreenState(newState: AddTweetState.error);
    }
  }
}
