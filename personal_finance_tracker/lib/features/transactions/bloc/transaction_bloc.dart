import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_tracker/core/models/transaction.dart' as custom;
import 'package:personal_finance_tracker/core/services/firestore_service.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final FirestoreService _firestoreService;

  TransactionBloc(this._firestoreService) : super(TransactionInitial()) {
    on<AddTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        await _firestoreService.addTransaction(event.userId, event.transaction);
        emit(TransactionSuccess());
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    });

    on<DeleteTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        await _firestoreService.deleteTransaction(event.userId, event.transactionId);
        emit(TransactionSuccess());
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    });
  }
}