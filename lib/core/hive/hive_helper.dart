import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class HiveHelper {
  static const String _userBox = 'userBox';
  static const String _profileImageKey = 'profileImageUrl';

  static Future<void> initHive() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    final hivePath = '${appDocumentDir.path}/hive';
    await Hive.initFlutter(hivePath);
    await Hive.openBox<String>(_userBox);
  }

  static Future<void> saveProfileImage(String? imageData) async {
    final box = Hive.box<String>(_userBox);
    if (imageData != null) {
      await box.put(_profileImageKey, imageData);
    } else {
      await box.delete(_profileImageKey);
    }
  }

  static String? getProfileImage() {
    final box = Hive.box<String>(_userBox);
    return box.get(_profileImageKey);
  }
}