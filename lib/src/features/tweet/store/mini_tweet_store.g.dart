// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mini_tweet_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MiniTweetStore on _MiniTweetStore, Store {
  late final _$likesQuantityAtom =
      Atom(name: '_MiniTweetStore.likesQuantity', context: context);

  @override
  int get likesQuantity {
    _$likesQuantityAtom.reportRead();
    return super.likesQuantity;
  }

  @override
  set likesQuantity(int value) {
    _$likesQuantityAtom.reportWrite(value, super.likesQuantity, () {
      super.likesQuantity = value;
    });
  }

  late final _$isLikedAtom =
      Atom(name: '_MiniTweetStore.isLiked', context: context);

  @override
  bool get isLiked {
    _$isLikedAtom.reportRead();
    return super.isLiked;
  }

  @override
  set isLiked(bool value) {
    _$isLikedAtom.reportWrite(value, super.isLiked, () {
      super.isLiked = value;
    });
  }

  late final _$iconLikeColorAtom =
      Atom(name: '_MiniTweetStore.iconLikeColor', context: context);

  @override
  Color? get iconLikeColor {
    _$iconLikeColorAtom.reportRead();
    return super.iconLikeColor;
  }

  @override
  set iconLikeColor(Color? value) {
    _$iconLikeColorAtom.reportWrite(value, super.iconLikeColor, () {
      super.iconLikeColor = value;
    });
  }

  late final _$_MiniTweetStoreActionController =
      ActionController(name: '_MiniTweetStore', context: context);

  @override
  dynamic tapLikeAction() {
    final _$actionInfo = _$_MiniTweetStoreActionController.startAction(
        name: '_MiniTweetStore.tapLikeAction');
    try {
      return super.tapLikeAction();
    } finally {
      _$_MiniTweetStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
likesQuantity: ${likesQuantity},
isLiked: ${isLiked},
iconLikeColor: ${iconLikeColor}
    ''';
  }
}
