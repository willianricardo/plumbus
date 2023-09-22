import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvironments {
  static Future<void> load() async {
    await dotenv.load(fileName: '.env');
  }

  static Future<void> testLoad() async {
    dotenv.testLoad(fileInput: File('test/.env').readAsStringSync());
  }

  static get(String key, [String def = '']) => dotenv.env[key] ?? def;
}
