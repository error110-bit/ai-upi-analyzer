import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/transactions/bloc/dashboard_bloc.dart';
import 'features/transactions/repository/sqlite_transaction_repository.dart';
import 'features/transactions/screens/dashboard_screen.dart';

void main() {
  final repository =
      SQLiteTransactionRepository();

  runApp(
    MyApp(
      repository: repository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final SQLiteTransactionRepository
      repository;

  const MyApp({
    super.key,
    required this.repository,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocProvider(
      create: (_) => DashboardBloc(
        repository,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner:
            false,
        title: 'UPI Expense Analyzer',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(
            seedColor: Colors.indigo,
          ),
        ),
        home:
            const DashboardScreen(),
      ),
    );
  }
}