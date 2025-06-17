import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthSignUpRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String? profileImg;

  const AuthSignUpRequested({
    required this.name,
    required this.email,
    required this.password,
    this.profileImg,
  });

  @override
  List<Object?> get props => [name, email, password, profileImg];
}

class AuthSignInRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthSignInRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthSignOutRequested extends AuthEvent {}

class AuthCheckVerificationRequested extends AuthEvent {} 