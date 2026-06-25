import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../transactions/bloc/dashboard_bloc.dart';
import '../../transactions/bloc/dashboard_state.dart';
import '../widgets/spending_pie_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Analytics',
        ),
      ),
      body: BlocBuilder<
          DashboardBloc,
          DashboardState>(
        builder: (
          context,
          state,
        ) {
          if (state
              is DashboardLoading) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (state
              is DashboardError) {
            return Center(
              child: Text(
                state.message,
              ),
            );
          }

          if (state
              is DashboardLoaded) {
            return SingleChildScrollView(
              padding:
                  const EdgeInsets.all(
                16,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  SpendingPieChart(
                    categorySpendings:
                        state
                            .categorySpendings,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  const Text(
                    'Category Breakdown',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  ...state.categorySpendings
                      .map(
                    (category) {
                      return Card(
                        child: ListTile(
                          leading:
                              const Icon(
                            Icons
                                .pie_chart,
                          ),
                          title: Text(
                            category
                                .category,
                          ),
                          trailing:
                              Text(
                            '₹${category.amount.toStringAsFixed(2)}',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}