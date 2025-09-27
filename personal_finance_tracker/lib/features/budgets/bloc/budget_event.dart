import 'package:personal_finance_tracker/core/models/budget.dart';

abstract class BudgetEvent {}

class AddBudget extends BudgetEvent {
  final String userId;
  final Budget budget;

  AddBudget(this.userId, this.budget);
}