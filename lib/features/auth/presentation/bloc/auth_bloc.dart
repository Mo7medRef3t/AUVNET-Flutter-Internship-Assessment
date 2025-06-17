// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:auvnet/features/auth/data/models/user_model.dart';
import 'package:auvnet/features/auth/domain/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;
  late StreamSubscription<User?> _authStateSubscription;

  AuthBloc({required this.authRepo}) : super(AuthInitial()) {
    on<AuthSignUpRequested>(_onSignUp);
    on<AuthSignInRequested>(_onSignIn);
    on<AuthSignOutRequested>(_onSignOut);
    on<AuthCheckVerificationRequested>(_onCheckVerification);

    _authStateSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        if (!user.emailVerified) {
          add(AuthCheckVerificationRequested());
        } else {
          final userModel = UserModel(
            id: user.uid,
            name: user.displayName ?? "",
            email: user.email ?? "",
            profileImg: user.photoURL,
          );
          emit(state.copyWith(user: userModel, error: null));
        }
      } else {
        emit( AuthInitial());
      }
    });
  }

  Future<void> _onSignUp(AuthSignUpRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final user = await authRepo.signUpWithEmail(
        name: event.name,
        email: event.email,
        password: event.password,
        profileImg: event.profileImg,
      );
      if (user != null) {
        emit(state.copyWith(user: user, isLoading: false));
      } else {
        emit(state.copyWith(isLoading: false, error: "Unknown error during signup"));
      }
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(isLoading: false, error: e.message));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onSignIn(AuthSignInRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final user = await authRepo.signInWithEmail(
        email: event.email,
        password: event.password,
      );
      if (user != null) {
        emit(state.copyWith(user: user, isLoading: false));
      } else {
        emit(state.copyWith(isLoading: false, error: "Unknown error during login"));
      }
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(isLoading: false, error: e.message));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onSignOut(AuthSignOutRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    await authRepo.signOut();
    emit(AuthInitial());
  }

  Future<void> _onCheckVerification(AuthCheckVerificationRequested event, Emitter<AuthState> emit) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && !currentUser.emailVerified) {
      await currentUser.sendEmailVerification();
      emit(state.copyWith(error: 'Please verify your email address. A verification email has been sent.'));
    } else if (currentUser != null && currentUser.emailVerified) {
      emit(state.copyWith(user: state.user, isLoading: false, error: null));
    }
  }

  @override
  Future<void> close() {
    _authStateSubscription.cancel();
    return super.close();
  }
}