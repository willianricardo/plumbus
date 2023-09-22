import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';

abstract class AppTranslations {
  static Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    // delegate from flutter_localization
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    // delegate from localization package.
    LocalJsonLocalization.delegate,
  ];

  static String translate(String key, {List<String> args = const []}) {
    return key.i18n(args);
  }

  static void load() {
    LocalJsonLocalization.delegate.directories = ['assets/lang'];
  }
}
