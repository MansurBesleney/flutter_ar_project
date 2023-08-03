import 'package:flutter/services.dart';

class ReadJson {
  
  Future<String>  readJson(String fileRoot) async {
    final String jsonData = await rootBundle.loadString(fileRoot);

    return jsonData;
  }
}