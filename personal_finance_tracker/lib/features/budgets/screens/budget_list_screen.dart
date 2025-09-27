import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_tracker/core/di/injector.dart';
import 'package:personal_finance_tracker/core/models/budget.dart';
import 'package:personal_finance_tracker/features/auth/bloc/auth_bloc.dart';
import 'package:personal_finance_tracker/core/services/firestore_service.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_finance_tracker/features/auth/bloc/auth_state.dart';
import 'package:personal_finance_tracker/features/budgets/bloc/budget_bloc.dart';
import 'add_budget_screen.dart';

class BudgetListScreen extends StatelessWidget {
  const BudgetListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AuthBloc>().state as AuthAuthenticated).user;

    return BlocProvider(
      create: (_) => locator<BudgetBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Budgets')),
        body: StreamBuilder<List<Budget>>(
          stream: locator<FirestoreService>().getBudgets(user.uid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final budgets = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: budgets.length,
              itemBuilder: (context, index) {
                final budget = budgets[index];
                return ListTile(
                  title: Text('${budget.category}: \$${budget.amount.toStringAsFixed(2)}'),
                  subtitle: Text('Period: ${DateFormat.yMMM().format(budget.period)}'),
                ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: 100 * index));
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddBudgetScreen()),
            );
          },
          backgroundColor: Colors.teal,
          child: const Icon(Icons.add),
        ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
      ),
    );
  }
}