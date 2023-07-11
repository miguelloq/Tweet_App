// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegistrationStore on _RegistrationStore, Store {
  late final _$registrationModelAtom =
      Atom(name: '_RegistrationStore.registrationModel', context: context);

  @override
  RegistrationRequestModel get registrationModel {
    _$registrationModelAtom.reportRead();
    return super.registrationModel;
  }

  @override
  set registrationModel(RegistrationRequestModel value) {
    _$registrationModelAtom.reportWrite(value, super.registrationModel, () {
      super.registrationModel = value;
    });
  }

  late final _$screenStateAtom =
      Atom(name: '_RegistrationStore.screenState', context: context);

  @override
  RegistrationState get screenState {
    _$screenStateAtom.reportRead();
    return super.screenState;
  }

  @override
  set screenState(RegistrationState value) {
    _$screenStateAtom.reportWrite(value, super.screenState, () {
      super.screenState = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_RegistrationStore.errorMessage', context: context);

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

  late final _$_RegistrationStoreActionController =
      ActionController(name: '_RegistrationStore', context: context);

  @override
  void changeModel(RegistrationRequestModel newModel) {
    final _$actionInfo = _$_RegistrationStoreActionController.startAction(
        name: '_RegistrationStore.changeModel');
    try {
      return super.changeModel(newModel);
    } finally {
      _$_RegistrationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setScreenState({required RegistrationState newState}) {
    final _$actionInfo = _$_RegistrationStoreActionController.startAction(
        name: '_RegistrationStore.setScreenState');
    try {
      return super.setScreenState(newState: newState);
    } finally {
      _$_RegistrationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void registrationAction() {
    final _$actionInfo = _$_RegistrationStoreActionController.startAction(
        name: '_RegistrationStore.registrationAction');
    try {
      return super.registrationAction();
    } finally {
      _$_RegistrationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
registrationModel: ${registrationModel},
screenState: ${screenState},
errorMessage: ${errorMessage}
    ''';
  }
}
