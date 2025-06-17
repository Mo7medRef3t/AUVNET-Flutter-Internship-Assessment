import 'package:auvnet/features/auth/data/models/user_model.dart';

abstract class AuthRepo {
  Future<UserModel?> signUpWithEmail({
    required String name,
    required String email,
    required String password,
    String? profileImg,
  });
  Future<UserModel?> signInWithEmail({
    required String email,
    required String password,
  });
  Future<void> signOut();
}