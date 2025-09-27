import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_tracker/core/constants/app_colors.dart';
import 'package:personal_finance_tracker/core/di/injector.dart';
import 'package:personal_finance_tracker/features/auth/bloc/auth_bloc.dart';
import 'package:personal_finance_tracker/features/auth/bloc/auth_event.dart';
import 'package:personal_finance_tracker/features/auth/bloc/auth_state.dart';
import 'package:personal_finance_tracker/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:personal_finance_tracker/features/dashboard/bloc/dashboard_event.dart';
import 'package:personal_finance_tracker/features/dashboard/bloc/dashboard_state.dart';
import 'package:personal_finance_tracker/features/transactions/screens/transaction_list_screen.dart';
import 'package:personal_finance_tracker/features/budgets/screens/budget_list_screen.dart';
import 'package:personal_finance_tracker/features/dashboard/widgets/spending_chart.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthBloc>().state is AuthAuthenticated
        ? (context.read<AuthBloc>().state as AuthAuthenticated).user
        : null;

    return BlocProvider(
      create: (_) => locator<DashboardBloc>()
        ..add(LoadDashboard(user?.uid ?? '')),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(AuthSignOut());
              },
            ),
          ],
        ),
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DashboardLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Spending Overview',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .slideX(begin: -0.2, end: 0),
                    const SizedBox(height: 16),
                    SpendingChart(transactions: state.transactions)
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 200.ms),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const TransactionListScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: const Text('View Transactions'),
                    ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const BudgetListScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: const Text('Manage Budgets'),
                    ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
                  ],
                ),
              );
            } else if (state is DashboardError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}