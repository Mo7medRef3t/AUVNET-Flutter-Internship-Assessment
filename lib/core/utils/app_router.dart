import 'package:auvnet/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  // static const kOnBordingView = '/onBordingView';
  

  static final router = GoRouter(routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashView()),
    // GoRoute(
    //   path: kOnBordingView,
    //   pageBuilder: (context, state) => CustomTransitionPage(
    //     key: state.pageKey,
    //     child: const OnBordingView(),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       return FadeTransition(
    //         opacity: animation,
    //         child: child,
    //       );
    //     },
    //   ),
    // ),
    
    // GoRoute(path: kSignUp, builder: (context, state) => const SignUpView()),
    // GoRoute(path: kSignIn, builder: (context, state) => const SignInView()),
    
    // GoRoute(path: kScreens, builder: (context, state) => const Screens()),
    // GoRoute(path: kHomePage, builder: (context, state) => const HomeView()),
    
  ]);
}
