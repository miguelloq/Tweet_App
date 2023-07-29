import 'package:tweet_app/src/features/tweet/services/get_tweet_information_service.dart';
import 'package:tweet_app/src/features/tweet/services/get_user_information_service.dart';

class GetFeedService {
  final GetUserInformationService getUser;
  final GetTweetInformationService getTweet;

  GetFeedService({required this.getTweet, required this.getUser});
}
