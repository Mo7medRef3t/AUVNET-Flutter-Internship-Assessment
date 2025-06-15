import 'package:auvnet/core/utils/app_router.dart';
import 'package:auvnet/core/utils/assets.dart';
import 'package:auvnet/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> fadeAnimation;


  @override
  void initState() {
    super.initState();
    _initAnimations();
    goNextPage();
  }

  void _initAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    fadeAnimation = Tween<double>(
      begin: 0.5,
      end: 1,
    ).animate(_animationController);

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Image.asset(
          AssetsData.logo,
          height: SizeConfig.defaultSize! * 32,
        ),
      ),
    );
  }

  void goNextPage() {
    Future.delayed(const Duration(seconds: 3), () async {
      // GoRouter.of(context).pushReplacement(AppRouter.kOnBordingView);
    });
  }
}
