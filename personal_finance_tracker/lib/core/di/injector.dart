import 'package:get_it/get_it.dart';
import 'package:personal_finance_tracker/core/services/auth_service.dart';
import 'package:personal_finance_tracker/core/services/firestore_service.dart';
import 'package:personal_finance_tracker/features/auth/bloc/auth_bloc.dart';
import 'package:personal_finance_tracker/features/transactions/bloc/transaction_bloc.dart';
import 'package:personal_finance_tracker/features/budgets/bloc/budget_bloc.dart';
import 'package:personal_finance_tracker/features/dashboard/bloc/dashboard_bloc.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerSingleton<FirestoreService>(FirestoreService());
  locator.registerFactory(() => AuthBloc(locator<AuthService>()));
  locator.registerFactory(() => TransactionBloc(locator<FirestoreService>()));
  locator.registerFactory(() => BudgetBloc(locator<FirestoreService>()));
  locator.registerFactory(() => DashboardBloc(locator<FirestoreService>()));
}