import 'package:personal_finance_tracker/core/models/transaction.dart' as custom;

abstract class TransactionEvent {}

class AddTransaction extends TransactionEvent {
  final String userId;
  final custom.Transaction transaction;

  AddTransaction(this.userId, this.transaction);
}

class DeleteTransaction extends TransactionEvent {
  final String userId;
  final String transactionId;

  DeleteTransaction(this.userId, this.transactionId);
}