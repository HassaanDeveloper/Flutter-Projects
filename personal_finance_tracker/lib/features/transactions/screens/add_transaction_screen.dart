import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_tracker/core/constants/app_colors.dart';
import 'package:personal_finance_tracker/core/models/transaction.dart';
import 'package:personal_finance_tracker/core/widgets/custom_button.dart';
import 'package:personal_finance_tracker/core/widgets/custom_text_field.dart';
import 'package:personal_finance_tracker/features/auth/bloc/auth_bloc.dart';
import 'package:personal_finance_tracker/features/auth/bloc/auth_state.dart';
import 'package:personal_finance_tracker/features/transactions/bloc/transaction_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance_tracker/features/transactions/bloc/transaction_event.dart';
import 'package:personal_finance_tracker/features/transactions/bloc/transaction_state.dart';
import 'package:uuid/uuid.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final amountController = TextEditingController();
    final categoryController = TextEditingController();
    final descriptionController = TextEditingController();
    String type = 'expense';

    return BlocProvider(
      create: (_) => context.read<TransactionBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Transaction')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<TransactionBloc, TransactionState>(
            listener: (context, state) {
              if (state is TransactionSuccess) {
                Navigator.pop(context);
              } else if (state is TransactionError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  CustomTextField(
                    label: 'Amount',
                    controller: amountController,
                    keyboardType: TextInputType.number,
                  ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Category',
                    controller: categoryController,
                  ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Description',
                    controller: descriptionController,
                  ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
                  const SizedBox(height: 16),
                  DropdownButton<String>(
                    value: type,
                    items: ['income', 'expense']
                        .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                        .toList(),
                    onChanged: (value) => type = value!,
                  ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Add Transaction',
                    isLoading: state is TransactionLoading,
                    onPressed: () {
                      final user = (context.read<AuthBloc>().state as AuthAuthenticated).user;
                      final transaction = Transaction(
                        id: const Uuid().v4(),
                        amount: double.parse(amountController.text),
                        category: categoryController.text,
                        type: type,
                        date: DateTime.now(),
                        description: descriptionController.text,
                      );
                      context.read<TransactionBloc>().add(
                            AddTransaction(user.uid, transaction),
                          );
                    },
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