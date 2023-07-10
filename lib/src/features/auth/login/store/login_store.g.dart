// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on _LoginStore, Store {
  late final _$errorMessageAtom =
      Atom(name: '_LoginStore.errorMessage', context: context);

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

  late final _$screenStateAtom =
      Atom(name: '_LoginStore.screenState', context: context);

  @override
  LoginState get screenState {
    _$screenStateAtom.reportRead();
    return super.screenState;
  }

  @override
  set screenState(LoginState value) {
    _$screenStateAtom.reportWrite(value, super.screenState, () {
      super.screenState = value;
    });
  }

  late final _$isPasswordFieldObscureAtom =
      Atom(name: '_LoginStore.isPasswordFieldObscure', context: context);

  @override
  bool get isPasswordFieldObscure {
    _$isPasswordFieldObscureAtom.reportRead();
    return super.isPasswordFieldObscure;
  }

  @override
  set isPasswordFieldObscure(bool value) {
    _$isPasswordFieldObscureAtom
        .reportWrite(value, super.isPasswordFieldObscure, () {
      super.isPasswordFieldObscure = value;
    });
  }

  late final _$_LoginStoreActionController =
      ActionController(name: '_LoginStore', context: context);

  @override
  void setScreenState({required LoginState newState}) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.setScreenState');
    try {
      return super.setScreenState(newState: newState);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changePasswordVisibility() {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.changePasswordVisibility');
    try {
      return super.changePasswordVisibility();
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loginAction() {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.loginAction');
    try {
      return super.loginAction();
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
screenState: ${screenState},
isPasswordFieldObscure: ${isPasswordFieldObscure}
    ''';
  }
}
