import 'package:tweet_app/src/features/tweet/models/tweet_request_model.dart';
import 'package:tweet_app/src/features/tweet/models/user_request_model.dart';

class TweetWithUserInformationModel {
  final UserRequestModel user;
  final TweetRequestModel tweet;

  TweetWithUserInformationModel({
    required this.user,
    required this.tweet,
  });

  DateTime getTweetDate() {
    return tweet.postCreationTime;
  }
}
