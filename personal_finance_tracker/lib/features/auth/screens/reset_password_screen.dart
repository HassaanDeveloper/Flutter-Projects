import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/core/constants/app_colors.dart';
import 'package:personal_finance_tracker/core/constants/app_strings.dart';
import 'package:personal_finance_tracker/core/widgets/custom_button.dart';
import 'package:personal_finance_tracker/core/widgets/custom_text_field.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                AppStrings.resetPassword,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: -0.2, end: 0),
              const SizedBox(height: 24),
              CustomTextField(
                label: AppStrings.password,
                controller: passwordController,
                obscureText: true,
              ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Confirm Password',
                controller: confirmPasswordController,
                obscureText: true,
              ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Reset Password',
                onPressed: () {
                  if (passwordController.text == confirmPasswordController.text) {
                    // Note: Firebase password reset is handled via email link.
                    // This screen is for UI purposes; actual reset requires Firebase email link handling.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Password reset link handling required')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Passwords do not match')),
                    );
                  }
                },
              ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(AppStrings.backToLogin),
              ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
            ],
          ),
        ),
      ),
    );
  }
}