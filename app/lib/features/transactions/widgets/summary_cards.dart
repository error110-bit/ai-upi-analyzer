import 'package:flutter/material.dart';

class SummaryCards extends StatelessWidget {
  final double totalIncome;
  final double totalExpenses;
  final int transactionCount;

  const SummaryCards({
    super.key,
    required this.totalIncome,
    required this.totalExpenses,
    required this.transactionCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.arrow_downward,
              color: Colors.green,
            ),
            title: const Text(
              'Total Income',
            ),
            subtitle: Text(
              '₹${totalIncome.toStringAsFixed(2)}',
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.arrow_upward,
              color: Colors.red,
            ),
            title: const Text(
              'Total Expenses',
            ),
            subtitle: Text(
              '₹${totalExpenses.toStringAsFixed(2)}',
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.receipt_long,
            ),
            title: const Text(
              'Transactions',
            ),
            subtitle: Text(
              '$transactionCount',
            ),
          ),
        ),
      ],
    );
  }
}