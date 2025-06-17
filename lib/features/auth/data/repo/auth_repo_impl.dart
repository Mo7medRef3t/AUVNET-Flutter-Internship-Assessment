import 'package:auvnet/features/auth/data/models/user_model.dart';
import 'package:auvnet/features/auth/domain/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserModel _fromFirebaseUser(User user) {
    return UserModel(
      id: user.uid,
      name: user.displayName ?? "",
      email: user.email ?? "",
      profileImg: user.photoURL,
    );
  }

  @override
  Future<UserModel?> signUpWithEmail({
    required String name,
    required String email,
    required String password,
    String? profileImg,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        await firebaseUser.updateDisplayName(name);
        if (profileImg != null) {
          await firebaseUser.updatePhotoURL(profileImg);
        }
        await firebaseUser.sendEmailVerification();
        await _firebaseAuth.signOut();
        return _fromFirebaseUser(firebaseUser);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Unknown error");
    }
  }

  @override
  Future<UserModel?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        if (!firebaseUser.emailVerified) {
          await firebaseUser.sendEmailVerification();
          await _firebaseAuth.signOut();
          throw Exception(
            'Please verify your email address. We have sent you another verification email.',
          );
        }
        return _fromFirebaseUser(firebaseUser);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Unknown error");
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
