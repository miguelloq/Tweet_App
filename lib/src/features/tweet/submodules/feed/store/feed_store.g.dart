// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FeedStore on _FeedStore, Store {
  late final _$feedScreenStateAtom =
      Atom(name: '_FeedStore.feedScreenState', context: context);

  @override
  FeedScreenState get feedScreenState {
    _$feedScreenStateAtom.reportRead();
    return super.feedScreenState;
  }

  @override
  set feedScreenState(FeedScreenState value) {
    _$feedScreenStateAtom.reportWrite(value, super.feedScreenState, () {
      super.feedScreenState = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_FeedStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$_FeedStoreActionController =
      ActionController(name: '_FeedStore', context: context);

  @override
  void setScreenState({required FeedScreenState newState}) {
    final _$actionInfo = _$_FeedStoreActionController.startAction(
        name: '_FeedStore.setScreenState');
    try {
      return super.setScreenState(newState: newState);
    } finally {
      _$_FeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
feedScreenState: ${feedScreenState},
errorMessage: ${errorMessage}
    ''';
  }
}
