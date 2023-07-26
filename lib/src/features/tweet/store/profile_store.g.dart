// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileStore on _ProfileStore, Store {
  late final _$profileScreenStateAtom =
      Atom(name: '_ProfileStore.profileScreenState', context: context);

  @override
  ProfileScreenState get profileScreenState {
    _$profileScreenStateAtom.reportRead();
    return super.profileScreenState;
  }

  @override
  set profileScreenState(ProfileScreenState value) {
    _$profileScreenStateAtom.reportWrite(value, super.profileScreenState, () {
      super.profileScreenState = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_ProfileStore.errorMessage', context: context);

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

  late final _$_ProfileStoreActionController =
      ActionController(name: '_ProfileStore', context: context);

  @override
  void setScreenState({required ProfileScreenState newState}) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.setScreenState');
    try {
      return super.setScreenState(newState: newState);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
profileScreenState: ${profileScreenState},
errorMessage: ${errorMessage}
    ''';
  }
}
