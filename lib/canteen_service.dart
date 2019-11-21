import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

Map<String, int> canteenIdMap = Map<String, int>();
List<String> menuToday = new List<String>();
List<String> menuThisWeek = List<String>();
List<String> menuNextWeek = List<String>();

class CanteenService {
  final _assetsTextStorage = AssetsTextStorage();
  final _localFileStorage = LocalFileStorage();

  Future<Map<String, int>> getCanteenMap() {

    return _assetsTextStorage
        .readFile(AssetsTextStorage.MENSA_CODE_FILENAMES)
        .then((canteenMapString) {

      var canteenMapList = new List<Map<String, int>>();
      canteenMapList.add(Map<String, int>());

      canteenMapString.split("\n").forEach((line) {
        if(line.isEmpty) {
          return;
        }

        var split = line.trim().split(new RegExp(r'\t+'));
        var canteenName = split[0];
        var canteenId = int.parse(split[1]);

        canteenIdMap.putIfAbsent(canteenName, () => canteenId);

        for (var value in split.sublist(2)) {
          switch (value) {
            case '1':
              menuToday.add(canteenName);
              break;
            case '2':
              menuThisWeek.add(canteenName);
              break;
            case '3':
              menuNextWeek.add(canteenName);
              break;
          }
        }
      });

      return canteenIdMap;
    });
  }
}

class AssetsTextStorage {
  // file added via assets in pubspec.yaml
  static const MENSA_CODE_FILENAMES = "res/canteen_codes.txt";

  Future<String> readFile(String path) async {
    debugPrint("Loading file $path");
    return await rootBundle.loadString(path);
  }
}

class LocalFileStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(filename) async {
    final path = await _localPath;
    return File('$path/$filename');
  }

  Future<String> readFile(filename) async {
    try {
      final file = await _localFile(filename);

      // Read the file.
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return empty string.
      return "";
    }
  }
}
