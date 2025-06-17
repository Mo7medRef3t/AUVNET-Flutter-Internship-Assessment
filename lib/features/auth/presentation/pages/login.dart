import 'package:auvnet/core/utils/app_router.dart';
import 'package:auvnet/core/utils/assets.dart';
import 'package:auvnet/core/utils/size_config.dart';
import 'package:auvnet/core/widgets/custom_buttons.dart';
import 'package:auvnet/core/widgets/custom_text_form_field.dart';
import 'package:auvnet/core/widgets/space_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auvnet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auvnet/features/auth/presentation/bloc/auth_event.dart';
import 'package:auvnet/features/auth/presentation/bloc/auth_state.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!)),
            );
          }

          if (state.user != null && state.error == null) {
            GoRouter.of(context).go(AppRouter.kScreens);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.defaultSize! * 8.5,
              left: SizeConfig.defaultSize! * 2,
              right: SizeConfig.defaultSize! * 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: SizeConfig.defaultSize! * 31,
                    height: SizeConfig.defaultSize! * 31,
                    child: Image.asset(AssetsData.logo, fit: BoxFit.contain),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: CustomTextFormField(
                    hintText: "mail",
                    icon: Icons.email_outlined,
                    controller: emailController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: CustomTextFormField(
                    hintText: "password",
                    icon: Icons.lock_outline,
                    isPassword: true,
                    controller: passwordController,
                  ),
                ),
                VerticalSpace(0.5),
                state.isLoading
                  ? const CircularProgressIndicator()
                  : CustomGeneralButton(
                      text: "Login",
                      onTap: () {
                        if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill all fields')),
                          );
                          return;
                        }
                        context.read<AuthBloc>().add(
                          AuthSignInRequested(
                            email: emailController.text.trim(),
                            password: passwordController.text,
                          ),
                        );
                      },
                    ),
                VerticalSpace(0.5),
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).pushReplacement(AppRouter.kSignup);
                  },
                  child: Text(
                    "Don't have an account? Sign Up",
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1877F2),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}