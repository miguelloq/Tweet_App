// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_tweet_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FullTweetStore on _FullTweetStore, Store {
  late final _$screenStateAtom =
      Atom(name: '_FullTweetStore.screenState', context: context);

  @override
  FullTweetScreenState get screenState {
    _$screenStateAtom.reportRead();
    return super.screenState;
  }

  @override
  set screenState(FullTweetScreenState value) {
    _$screenStateAtom.reportWrite(value, super.screenState, () {
      super.screenState = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_FullTweetStore.errorMessage', context: context);

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

  late final _$_FullTweetStoreActionController =
      ActionController(name: '_FullTweetStore', context: context);

  @override
  dynamic setScreenState({required FullTweetScreenState newState}) {
    final _$actionInfo = _$_FullTweetStoreActionController.startAction(
        name: '_FullTweetStore.setScreenState');
    try {
      return super.setScreenState(newState: newState);
    } finally {
      _$_FullTweetStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
screenState: ${screenState},
errorMessage: ${errorMessage}
    ''';
  }
}
