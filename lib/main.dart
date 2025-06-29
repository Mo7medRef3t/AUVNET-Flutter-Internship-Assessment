import 'package:auvnet/core/hive/hive_helper.dart';
import 'package:auvnet/core/utils/app_router.dart';
import 'package:auvnet/core/utils/size_config.dart';
import 'package:auvnet/features/auth/data/repo/auth_repo_impl.dart';
import 'package:auvnet/firebase_options.dart';
import 'package:auvnet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveHelper.initHive();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    BlocProvider<AuthBloc>(
      create: (_) => AuthBloc(authRepo: AuthRepoImpl()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig().init(context);

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
          theme: ThemeData(
            textTheme: GoogleFonts.rubikTextTheme(),
            scaffoldBackgroundColor: Colors.white,
          ),
        );
      },
    );
  }
}
