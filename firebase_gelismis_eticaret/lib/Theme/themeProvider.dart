
import 'package:firebase_gelismis_eticaret/Theme/thems.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData=ligthMod;

  ThemeData get themeData => _themeData;

  bool get isDarkMod=>_themeData==darkMod;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toogleTheme(){
    if(_themeData==ligthMod){
      themeData=darkMod;
    }
    else{
      themeData=ligthMod;
    }
  }
}