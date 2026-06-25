import 'package:flutter/material.dart';

import '../models/transaction.dart';

class RecentTransactions extends StatelessWidget {
  final List<Transaction> transactions;
  final int? limit;

  const RecentTransactions({
    super.key,
    required this.transactions,
    this.limit,
  });

  @override
  Widget build(BuildContext context) {
    final displayTransactions =
      limit == null
          ? transactions
          : transactions.take(limit!).toList();
    if (displayTransactions.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text(
              'No transactions yet',
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Transactions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(
          height: 12,
        ),

        ...displayTransactions.map(
          (transaction) {
            return Card(
              child: ListTile(
                leading: Icon(
                  transaction.type ==
                          TransactionType.expense
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  color:
                      transaction.type ==
                              TransactionType
                                  .expense
                          ? Colors.red
                          : Colors.green,
                ),
                title: Text(
                  transaction.merchant,
                ),
                subtitle: Text(
                  transaction.category,
                ),
                trailing: Text(
                  '₹${transaction.amount.toStringAsFixed(2)}',
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}