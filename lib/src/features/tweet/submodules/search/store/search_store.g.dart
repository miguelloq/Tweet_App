// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SearchStore on _SearchStore, Store {
  late final _$searchStateAtom =
      Atom(name: '_SearchStore.searchState', context: context);

  @override
  SearchState get searchState {
    _$searchStateAtom.reportRead();
    return super.searchState;
  }

  @override
  set searchState(SearchState value) {
    _$searchStateAtom.reportWrite(value, super.searchState, () {
      super.searchState = value;
    });
  }

  late final _$_SearchStoreActionController =
      ActionController(name: '_SearchStore', context: context);

  @override
  void setScreenState({required SearchState newState}) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.setScreenState');
    try {
      return super.setScreenState(newState: newState);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchState: ${searchState}
    ''';
  }
}
