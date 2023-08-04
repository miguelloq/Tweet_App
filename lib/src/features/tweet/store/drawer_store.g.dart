// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawer_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DrawerStore on _DrawerStore, Store {
  late final _$screenStateAtom =
      Atom(name: '_DrawerStore.screenState', context: context);

  @override
  DrawerScreenState get screenState {
    _$screenStateAtom.reportRead();
    return super.screenState;
  }

  @override
  set screenState(DrawerScreenState value) {
    _$screenStateAtom.reportWrite(value, super.screenState, () {
      super.screenState = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_DrawerStore.errorMessage', context: context);

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

  late final _$_DrawerStoreActionController =
      ActionController(name: '_DrawerStore', context: context);

  @override
  dynamic setScreenState({required DrawerScreenState newState}) {
    final _$actionInfo = _$_DrawerStoreActionController.startAction(
        name: '_DrawerStore.setScreenState');
    try {
      return super.setScreenState(newState: newState);
    } finally {
      _$_DrawerStoreActionController.endAction(_$actionInfo);
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
