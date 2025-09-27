import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_tracker/core/models/transaction.dart';
import 'package:personal_finance_tracker/core/services/firestore_service.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final FirestoreService _firestoreService;

  DashboardBloc(this._firestoreService) : super(DashboardInitial()) {
    on<LoadDashboard>((event, emit) async {
      emit(DashboardLoading());
      try {
        final Stream<List<Transaction>> transactionsStream = _firestoreService.getTransactions(event.userId).cast<List<Transaction>>();
        final budgetsStream = _firestoreService.getBudgets(event.userId);
        emit(DashboardLoaded(transactionsStream, budgetsStream));
      } catch (e) {
        emit(DashboardError(e.toString()));
      }
  });
}}