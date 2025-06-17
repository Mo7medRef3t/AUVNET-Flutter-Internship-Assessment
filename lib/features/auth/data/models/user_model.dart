import 'package:auvnet/core/hive/hive_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String email;
  String? profileImg;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profileImg,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profileImg: map['profileImg'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'profileImg': profileImg};
  }

  Future<void> updateProfileImage(XFile? imageFile) async {
    if (imageFile != null) {
      final bytes = await imageFile.readAsBytes();
      profileImg = base64Encode(bytes);
      await HiveHelper.saveProfileImage(profileImg);
    } else {
      profileImg = null;
      await HiveHelper.saveProfileImage(null);
    }
  }
}
