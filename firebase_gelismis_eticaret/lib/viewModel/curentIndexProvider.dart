import 'package:flutter/cupertino.dart';

class CurentIndexProvider with ChangeNotifier{
  int _secilenMenuItem=0;

  int get secilenMenuItem => _secilenMenuItem;

  set secilenMenuItem(int value) {
    _secilenMenuItem = value;
    notifyListeners();
  }
}