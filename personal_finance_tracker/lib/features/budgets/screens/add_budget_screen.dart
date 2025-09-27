import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_tracker/core/constants/app_colors.dart';
import 'package:personal_finance_tracker/core/models/budget.dart';
import 'package:personal_finance_tracker/core/widgets/custom_button.dart';
import 'package:personal_finance_tracker/core/widgets/custom_text_field.dart';
import 'package:personal_finance_tracker/features/auth/bloc/auth_bloc.dart';
import 'package:personal_finance_tracker/features/auth/bloc/auth_state.dart';
import 'package:personal_finance_tracker/features/budgets/bloc/budget_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_finance_tracker/features/budgets/bloc/budget_event.dart';
import 'package:personal_finance_tracker/features/budgets/bloc/budget_state.dart';
import 'package:uuid/uuid.dart';

class AddBudgetScreen extends StatelessWidget {
  const AddBudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = TextEditingController();
    final amountController = TextEditingController();

    return BlocProvider(
      create: (_) => context.read<BudgetBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Budget')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<BudgetBloc, BudgetState>(
            listener: (context, state) {
              if (state is BudgetSuccess) {
                Navigator.pop(context);
              } else if (state is BudgetError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  CustomTextField(
                    label: 'Category',
                    controller: categoryController,
                  ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Amount',
                    controller: amountController,
                    keyboardType: TextInputType.number,
                  ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Add Budget',
                    isLoading: state is BudgetLoading,
                    onPressed: () {
                      final user = (context.read<AuthBloc>().state as AuthAuthenticated).user;
                      final budget = Budget(
                        id: const Uuid().v4(),
                        category: categoryController.text,
                        amount: double.parse(amountController.text),
                        period: DateTime.now(),
                      );
                      context.read<BudgetBloc>().add(
                            AddBudget(user.uid, budget),
                          );
                    },
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