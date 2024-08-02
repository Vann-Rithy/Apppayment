import 'package:flutter/material.dart';

class LocaleNotifier with ChangeNotifier {
  Locale _locale = Locale('km', 'KH');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (locale != _locale) {
      _locale = locale;
      notifyListeners();
    }
  }
}
