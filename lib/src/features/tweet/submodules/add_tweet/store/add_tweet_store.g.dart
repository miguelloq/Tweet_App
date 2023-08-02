// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_tweet_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddTweetStore on _AddTweetStore, Store {
  late final _$errorTextAtom =
      Atom(name: '_AddTweetStore.errorText', context: context);

  @override
  String? get errorText {
    _$errorTextAtom.reportRead();
    return super.errorText;
  }

  @override
  set errorText(String? value) {
    _$errorTextAtom.reportWrite(value, super.errorText, () {
      super.errorText = value;
    });
  }

  late final _$addTweetStateAtom =
      Atom(name: '_AddTweetStore.addTweetState', context: context);

  @override
  AddTweetState get addTweetState {
    _$addTweetStateAtom.reportRead();
    return super.addTweetState;
  }

  @override
  set addTweetState(AddTweetState value) {
    _$addTweetStateAtom.reportWrite(value, super.addTweetState, () {
      super.addTweetState = value;
    });
  }

  late final _$chosenImagesAtom =
      Atom(name: '_AddTweetStore.chosenImages', context: context);

  @override
  List<ImageRequestModel> get chosenImages {
    _$chosenImagesAtom.reportRead();
    return super.chosenImages;
  }

  @override
  set chosenImages(List<ImageRequestModel> value) {
    _$chosenImagesAtom.reportWrite(value, super.chosenImages, () {
      super.chosenImages = value;
    });
  }

  late final _$_AddTweetStoreActionController =
      ActionController(name: '_AddTweetStore', context: context);

  @override
  void newScreenState({required AddTweetState newState}) {
    final _$actionInfo = _$_AddTweetStoreActionController.startAction(
        name: '_AddTweetStore.newScreenState');
    try {
      return super.newScreenState(newState: newState);
    } finally {
      _$_AddTweetStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addImageInChosenImages(
      {required File file, required String path, required String name}) {
    final _$actionInfo = _$_AddTweetStoreActionController.startAction(
        name: '_AddTweetStore.addImageInChosenImages');
    try {
      return super.addImageInChosenImages(file: file, path: path, name: name);
    } finally {
      _$_AddTweetStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeImageInChosenImages({required int position}) {
    final _$actionInfo = _$_AddTweetStoreActionController.startAction(
        name: '_AddTweetStore.removeImageInChosenImages');
    try {
      return super.removeImageInChosenImages(position: position);
    } finally {
      _$_AddTweetStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTweetAction({String? commentedTweetDocName}) {
    final _$actionInfo = _$_AddTweetStoreActionController.startAction(
        name: '_AddTweetStore.addTweetAction');
    try {
      return super.addTweetAction(commentedTweetDocName: commentedTweetDocName);
    } finally {
      _$_AddTweetStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorText: ${errorText},
addTweetState: ${addTweetState},
chosenImages: ${chosenImages}
    ''';
  }
}
