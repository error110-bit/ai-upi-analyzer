import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/sms_import_service.dart';

import '../models/category_spending.dart';
import '../models/transaction.dart';
import '../repository/transaction_repository.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc
    extends Bloc<DashboardEvent, DashboardState> {
  final TransactionRepository repository;
  final SmsImportService smsImportService;

  DashboardBloc(
    this.repository,
    this.smsImportService,
  ) : super(
          const DashboardInitial(),
        ) {
    on<FetchDashboardData>(
      _onFetchDashboardData,
    );

    on<RefreshDashboard>(
      _onRefreshDashboard,
    );

    on<DeleteTransaction>(
      _onDeleteTransaction,
    );

    on<AddTransaction>(
      _onAddTransaction,
    );

    on<ImportSms>(
      _onImportSms,
    );
  }

  Future<void> _onFetchDashboardData(
    FetchDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    await _loadDashboard(
      emit,
    );
  }

  Future<void> _onRefreshDashboard(
    RefreshDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    await _loadDashboard(
      emit,
    );
  }

  Future<void> _onDeleteTransaction(
    DeleteTransaction event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      await repository.deleteTransaction(
        event.transactionId,
      );

      await _loadDashboard(
        emit,
      );
    } on Exception {
      emit(
        const DashboardError(
          'Failed to delete transaction',
        ),
      );
    }
  }

  Future<void> _onAddTransaction(
    AddTransaction event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      await repository.saveTransaction(
        event.transaction,
      );

      await _loadDashboard(
        emit,
      );
    } on Exception {
      emit(
        const DashboardError(
          'Failed to add transaction',
        ),
      );
    }
  }
  
  Future<void> _onImportSms(
    ImportSms event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      final transactions =
          await smsImportService
              .importTransactions();

      await repository
          .saveTransactions(
        transactions,
      );

      await _loadDashboard(
        emit,
      );
    } on Exception {
      emit(
        const DashboardError(
          'Failed to import SMS',
        ),
      );
    }
  }

  Future<void> _loadDashboard(
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(
        const DashboardLoading(),
      );

      final transactions =
          await repository.getAllTransactions();

      final totalExpenses =
          _calculateTotalExpenses(
        transactions,
      );

      final totalIncome =
          _calculateTotalIncome(
        transactions,
      );

      final categorySpendings =
          _calculateCategorySpendings(
        transactions,
      );

      emit(
        DashboardLoaded(
          transactions: transactions,
          totalExpenses: totalExpenses,
          totalIncome: totalIncome,
          categorySpendings:
              categorySpendings,
        ),
      );
    } on Exception {
      emit(
        const DashboardError(
          'Failed to load dashboard data',
        ),
      );
    }
  }
  
  double _calculateTotalExpenses(
    List<Transaction> transactions,
  ) {
    return transactions
        .where(
          (transaction) =>
              transaction.type ==
              TransactionType.expense,
        )
        .fold(
          0.0,
          (sum, transaction) =>
              sum + transaction.amount,
        );
  }

  double _calculateTotalIncome(
    List<Transaction> transactions,
  ) {
    return transactions
        .where(
          (transaction) =>
              transaction.type ==
              TransactionType.income,
        )
        .fold(
          0.0,
          (sum, transaction) =>
              sum + transaction.amount,
        );
  }

  List<CategorySpending>
      _calculateCategorySpendings(
    List<Transaction> transactions,
  ) {
    final Map<String, double>
        categoryTotals = {};

    for (final transaction
        in transactions) {
      if (transaction.type !=
          TransactionType.expense) {
        continue;
      }

      categoryTotals.update(
        transaction.category,
        (value) =>
            value + transaction.amount,
        ifAbsent: () =>
            transaction.amount,
      );
    }

    return categoryTotals.entries
        .map(
          (entry) =>
              CategorySpending(
            category: entry.key,
            amount: entry.value,
          ),
        )
        .toList();
  }
}