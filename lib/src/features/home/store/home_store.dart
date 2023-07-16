import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  int currentPage = 0;

  final PageController pageViewController = PageController();

  @action
  changeCurrentPage(int newValue) {
    currentPage = newValue;
    pageViewController.jumpToPage(currentPage);
  }
}
