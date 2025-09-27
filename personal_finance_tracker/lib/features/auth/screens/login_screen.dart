import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_tracker/core/constants/app_colors.dart';
import 'package:personal_finance_tracker/core/widgets/custom_button.dart';
import 'package:personal_finance_tracker/core/widgets/custom_text_field.dart';
import 'package:personal_finance_tracker/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_finance_tracker/features/auth/bloc/auth_event.dart';
import 'package:personal_finance_tracker/features/auth/bloc/auth_state.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome Back',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: -0.2, end: 0),
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: 'Email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Password',
                    controller: passwordController,
                    obscureText: true,
                  ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Login',
                    isLoading: state is AuthLoading,
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            AuthLogin(
                              emailController.text,
                              passwordController.text,
                            ),
                          );
                    },
                  ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ForgotPasswordScreen()),
                      );
                    },
                    child: const Text('Forgot Password?'),
                  ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      );
                    },
                    child: const Text('Don’t have an account? Sign Up'),
                  ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}