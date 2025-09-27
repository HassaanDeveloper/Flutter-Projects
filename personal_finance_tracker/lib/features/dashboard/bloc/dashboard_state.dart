import 'package:personal_finance_tracker/core/models/budget.dart';
import 'package:personal_finance_tracker/core/models/transaction.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final Stream<List<Transaction>> transactions;
  final Stream<List<Budget>> budgets;

  DashboardLoaded(this.transactions, this.budgets);
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);
}