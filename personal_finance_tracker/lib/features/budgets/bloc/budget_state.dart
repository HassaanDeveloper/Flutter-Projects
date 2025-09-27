abstract class BudgetState {}

class BudgetInitial extends BudgetState {}

class BudgetLoading extends BudgetState {}

class BudgetSuccess extends BudgetState {}

class BudgetError extends BudgetState {
  final String message;

  BudgetError(this.message);
}