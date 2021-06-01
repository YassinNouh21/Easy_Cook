import 'package:flutter/cupertino.dart';

class admin extends ChangeNotifier {
  bool isAdmin = false;

  changeIsAdmin(bool value) {
    isAdmin = value;
    notifyListeners();
  }
}
