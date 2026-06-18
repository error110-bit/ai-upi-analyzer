import 'package:equatable/equatable.dart';

enum TransactionType {
  income,
  expense,
}

class Transaction extends Equatable {
  final String id;

  final double amount;

  final String merchant;

  final DateTime timestamp;

  final TransactionType type;

  final String category;

  const Transaction({
    required this.id,
    required this.amount,
    required this.merchant,
    required this.timestamp,
    required this.type,
    required this.category,
  });

  Transaction copyWith({
    String? id,
    double? amount,
    String? merchant,
    DateTime? timestamp,
    TransactionType? type,
    String? category,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      merchant: merchant ?? this.merchant,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'merchant': merchant,
      'timestamp': timestamp.toIso8601String(),
      'type': type.name,
      'category': category,
    };
  }

  factory Transaction.fromJson(
    Map<String, dynamic> json,
  ) {
    return Transaction(
      id: json['id'],
      amount: (json['amount'] as num).toDouble(),
      merchant: json['merchant'],
      timestamp: DateTime.parse(
        json['timestamp'],
      ),
      type: json['type'] == 'income'
          ? TransactionType.income
          : TransactionType.expense,
      category: json['category'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        amount,
        merchant,
        timestamp,
        type,
        category,
      ];
}