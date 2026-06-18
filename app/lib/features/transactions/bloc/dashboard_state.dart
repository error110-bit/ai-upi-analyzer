import 'package:equatable/equatable.dart';

import '../models/category_spending.dart';
import '../models/transaction.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoaded extends DashboardState {
  final List<Transaction> transactions;

  final double totalExpenses;

  final double totalIncome;

  final List<CategorySpending>
      categorySpendings;

  const DashboardLoaded({
    required this.transactions,
    required this.totalExpenses,
    required this.totalIncome,
    required this.categorySpendings,
  });

  @override
  List<Object?> get props => [
        transactions,
        totalExpenses,
        totalIncome,
        categorySpendings,
      ];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(
    this.message,
  );

  @override
  List<Object?> get props => [
        message,
      ];
}