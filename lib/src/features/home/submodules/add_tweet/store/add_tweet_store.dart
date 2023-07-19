import 'package:mobx/mobx.dart';
import 'package:tweet_app/src/core/repositories/tweet_repository_firestore.dart';
import 'package:tweet_app/src/features/home/submodules/add_tweet/models/add_tweet_request_model.dart';

part 'add_tweet_store.g.dart';

enum AddTweetState { success, error, waiting }

class AddTweetStore = _AddTweetStore with _$AddTweetStore;

abstract class _AddTweetStore with Store {
  final TweetRepositoryFirestore repository;
  final String userUid;

  AddTweetRequestModel requestModel;

  _AddTweetStore({required this.repository, required this.userUid})
      : requestModel = AddTweetRequestModel(
          userUid: userUid,
          message: '',
        );

  @observable
  String? errorText;

  @observable
  AddTweetState addTweetState = AddTweetState.waiting;

  @action
  void setState({required AddTweetState newState}) {
    if (addTweetState == AddTweetState.error &&
        newState != AddTweetState.error) {
      errorText = null;
    }
    addTweetState = newState;
  }

  void setMessage({required String newMessage}) {
    requestModel = requestModel.copyWith(message: newMessage);
  }

  @action
  void addTweetAction() {
    repository
        .createTweet(
            uidAuth: requestModel.userUid,
            bodyText: requestModel.message,
            postCreationTime: DateTime.now())
        .then((value) {
      setState(newState: AddTweetState.success);
    });
  }
}
