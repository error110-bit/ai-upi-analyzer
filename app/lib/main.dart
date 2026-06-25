import 'package:app/features/transactions/services/sms_import_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/transactions/bloc/dashboard_bloc.dart';
import 'features/transactions/repository/sqlite_transaction_repository.dart';
import 'features/transactions/screens/dashboard_screen.dart';
import 'features/transactions/services/real_sms_import_service.dart';
import 'features/home/screens/home_screen.dart';

void main() {
  final repository =
      SQLiteTransactionRepository();
  final smsImportService =
      RealSmsImportService();

  runApp(
    MyApp(
      repository: repository,
      smsImportService: smsImportService,
    ),
  );
}

class MyApp extends StatelessWidget {
  final SQLiteTransactionRepository
      repository;
  final SmsImportService
      smsImportService;

  const MyApp({
    super.key,
    required this.repository,
    required this.smsImportService,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocProvider(
      create: (_) => DashboardBloc(
        repository,
        smsImportService,
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
            const HomeScreen(),
      ),
    );
  }
}