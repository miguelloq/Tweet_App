import 'package:mobx/mobx.dart';

part 'tweet_store.g.dart';

class TweetStore = _TweetStore with _$TweetStore;

abstract class _TweetStore with Store {}
