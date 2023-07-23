import 'package:mobx/mobx.dart';

part 'feed_store.g.dart';

class FeedStore = _FeedStore with _$FeedStore;

abstract class _FeedStore with Store {
  @observable
  int counter = 0;

  @action
  incrementCounter() {
    counter++;
  }
}
