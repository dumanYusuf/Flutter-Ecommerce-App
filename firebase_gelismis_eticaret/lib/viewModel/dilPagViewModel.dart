import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

class DilPageViewModel with ChangeNotifier{

  Map<String,dynamic>_languages={
    "tr":"Türkçe",
    "en":"English"
  };

  Map<String, dynamic> get languages => _languages;

  String _selectedLanguageCode="tr";

  String get selectedLanguageCode => _selectedLanguageCode;

  set selectedLanguageCode(String value) {
    _selectedLanguageCode = value;
    notifyListeners();
  }

}