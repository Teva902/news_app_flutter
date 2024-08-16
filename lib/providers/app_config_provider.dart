import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'en';
  int page = 1;

  String search = '';

  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }

  void changePageNumber(int newNumOfPage) {
    if (page == newNumOfPage) {
      return;
    }
    page = newNumOfPage;
    notifyListeners();
  }

  void changeSearch(String newSearch) {
    if (search == newSearch) {
      return;
    }
    search = newSearch;
    notifyListeners();
  }
}
