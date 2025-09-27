import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_tracker/core/models/budget.dart';
import 'package:personal_finance_tracker/core/services/firestore_service.dart';
import 'budget_event.dart';
import 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final FirestoreService _firestoreService;

  BudgetBloc(this._firestoreService) : super(BudgetInitial()) {
    on<AddBudget>((event, emit) async {
      emit(BudgetLoading());
      try {
        await _firestoreService.addBudget(event.userId, event.budget);
        emit(BudgetSuccess());
      } catch (e) {
        emit(BudgetError(e.toString()));
      }
    });
  }
}