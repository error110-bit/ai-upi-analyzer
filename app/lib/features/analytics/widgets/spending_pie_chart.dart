import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../transactions/models/category_spending.dart';

class SpendingPieChart extends StatelessWidget {
  final List<CategorySpending> categorySpendings;

  const SpendingPieChart({
    super.key,
    required this.categorySpendings,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(
          16,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Spending Analytics',
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            if (categorySpendings.isEmpty)
              const SizedBox(
                height: 220,
                child: Center(
                  child: Text(
                    'No spending data available',
                  ),
                ),
              )
            else
              SizedBox(
                height: 250,
                child: PieChart(
                  PieChartData(
                    sections:
                        categorySpendings
                            .map(
                              (category) =>
                                  PieChartSectionData(
                                value: category
                                    .amount,
                                title: category
                                    .category,
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}