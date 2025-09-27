import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_tracker/core/di/injector.dart';
import 'package:personal_finance_tracker/core/models/transaction.dart';
import 'package:personal_finance_tracker/features/auth/bloc/auth_bloc.dart';
import 'package:personal_finance_tracker/features/auth/bloc/auth_state.dart';
import 'package:personal_finance_tracker/features/transactions/bloc/transaction_bloc.dart';


import 'package:personal_finance_tracker/core/services/firestore_service.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_finance_tracker/features/transactions/bloc/transaction_event.dart';
import 'add_transaction_screen.dart';

class TransactionListScreen extends StatelessWidget {
  const TransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AuthBloc>().state as AuthAuthenticated).user;

    return BlocProvider(
      create: (_) => locator<TransactionBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Transactions')),
        body: StreamBuilder<List<Transaction>>(
          stream: locator<FirestoreService>().getTransactions(user.uid).cast<List<Transaction>>(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('No transactions found.'));
            }
            final transactions = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  title: Text('${transaction.type}: \$${transaction.amount.toStringAsFixed(2)}'),
                  subtitle: Text('${transaction.category} - ${DateFormat.yMMMd().format(transaction.date)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context.read<TransactionBloc>().add(
                            DeleteTransaction(user.uid, transaction.id),
                          );
                    },
                  ),
                ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: 100 * index));
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
            );
          },
          backgroundColor: Colors.teal,
          child: const Icon(Icons.add),
        ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
      ),
    );
  }
}