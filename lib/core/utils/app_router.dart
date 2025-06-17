import 'package:auvnet/features/auth/presentation/pages/login.dart';
import 'package:auvnet/features/auth/presentation/pages/signup.dart';
import 'package:auvnet/features/home/presentation/views/widgets/product_details_screen.dart';
import 'package:auvnet/features/onbording/presentation/views/on_bording_view.dart';
import 'package:auvnet/features/products/data/models/product_model.dart';
import 'package:auvnet/features/splash/presentation/views/splash_view.dart';
import 'package:auvnet/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kOnBordingView = '/onBordingView';
  static const kLogin = '/login';
  static const kSignup = '/signup';
  static const kScreens = '/screens';
  static const kProductDetails = '/productDetails';

  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(
        path: kOnBordingView,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const OnBordingView(),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
      ),

      GoRoute(path: kSignup, builder: (context, state) => const Signup()),
      GoRoute(path: kLogin, builder: (context, state) => const Login()),

      GoRoute(path: kScreens, builder: (context, state) => const Screens()),
    GoRoute(
        path: kProductDetails,
        builder: (context, state) {
          final product = state.extra as ProductModel?;
          if (product == null) return const SizedBox.shrink();
          return ProductDetailsScreen(product: product);
        },
      ),
    ],
  );
}
