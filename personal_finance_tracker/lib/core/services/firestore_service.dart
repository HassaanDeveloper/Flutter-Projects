import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:personal_finance_tracker/core/models/transaction.dart' as custom;
import 'package:personal_finance_tracker/core/models/budget.dart';

class FirestoreService {
  final firestore.FirebaseFirestore _firestore = firestore.FirebaseFirestore.instance;

  Future<void> addTransaction(String userId, custom.Transaction transaction) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .doc(transaction.id)
        .set(transaction.toMap());
  }

  Stream<List<custom.Transaction>> getTransactions(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => custom.Transaction.fromMap(doc.data()))
            .toList());
  }

  Future<void> deleteTransaction(String userId, String transactionId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .doc(transactionId)
        .delete();
  }

  Future<void> addBudget(String userId, Budget budget) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('budgets')
        .doc(budget.id)
        .set(budget.toMap());
  }

  Stream<List<Budget>> getBudgets(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('budgets')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Budget.fromMap(doc.data())).toList());
  }
}