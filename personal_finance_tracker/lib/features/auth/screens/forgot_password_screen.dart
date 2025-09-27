import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_tracker/core/constants/app_colors.dart';
import 'package:personal_finance_tracker/core/widgets/custom_button.dart';
import 'package:personal_finance_tracker/core/widgets/custom_text_field.dart';
import 'package:personal_finance_tracker/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_finance_tracker/features/auth/bloc/auth_event.dart';
import 'package:personal_finance_tracker/features/auth/bloc/auth_state.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthPasswordResetSent) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Password reset email sent!')),
                );
                Navigator.pop(context);
              } else if (state is AuthError) {
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
                    'Reset Password',
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
                  CustomButton(
                    text: 'Send Reset Email',
                    isLoading: state is AuthLoading,
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(AuthForgotPassword(emailController.text));
                    },
                  ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back to Login'),
                  ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}