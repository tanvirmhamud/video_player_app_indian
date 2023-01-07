import 'package:flutter/cupertino.dart';

class MusicSearchProvider extends ChangeNotifier {
  String searchTerm = "";
  bool searchActive = false;

  String get getSearchTerm => searchTerm;
  bool get getSearchActive => searchActive;

  updateSearchTerm(String search) {
    searchTerm = search;
    notifyListeners();
  }

  updateSearchActive(bool active) {
    searchActive = active;
    notifyListeners();
  }
}
