import 'package:auvnet/features/auth/data/models/user_model.dart';
import 'package:auvnet/features/home/presentation/views/widgets/home_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final UserModel user;

  const HomeView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return HomeBody(user: user);
  }
}