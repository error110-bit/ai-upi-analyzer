import 'package:equatable/equatable.dart';

enum TransactionType {
  expense,
  income,
}

class Transaction extends Equatable {
  final double amount;
  final String merchant;
  final DateTime date;
  final TransactionType type;
  final String category;

  const Transaction({
    required this.amount,
    required this.merchant,
    required this.date,
    required this.type,
    required this.category,
  });

  @override
  List<Object?> get props => [
        amount,
        merchant,
        date,
        type,
        category,
      ];
}