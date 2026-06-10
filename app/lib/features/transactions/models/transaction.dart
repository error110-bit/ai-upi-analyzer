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

  Map<String, dynamic> toJson() {
  return {
    'amount': amount,
    'merchant': merchant,
    'date': date.toIso8601String(),
    'type': type.name,
    'category': category,
   };
  }

   factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      amount: json['amount'],
      merchant: json['merchant'],
      date: DateTime.parse(json['date']),
      type: json['type'] == 'income'
        ? TransactionType.income
        : TransactionType.expense,
      category: json['category'],
    );
  }

  @override
  List<Object?> get props => [
        amount,
        merchant,
        date,
        type,
        category,
      ];
}