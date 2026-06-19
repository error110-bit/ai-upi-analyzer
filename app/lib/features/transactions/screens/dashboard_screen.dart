import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback(
      (_) {
        context.read<DashboardBloc>().add(
          const FetchDashboardData(),
        );
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text(
          'UPI Expense Analyzer',
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.download,
            ),
            onPressed: () {
              context.read<DashboardBloc>().add(
                const ImportSms(),
              );
            },
          ),
        ],
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

          if (state is DashboardError) {
            return Center(
              child: Text(
                state.message,
              ),
            );
          }

          if (state is DashboardLoaded) {
            final recentTransactions =
                state.transactions
                    .take(5)
                    .toList();

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
                  Card(
                    child: ListTile(
                      title: const Text(
                        'Total Income',
                      ),
                      subtitle: Text(
                        '₹${state.totalIncome.toStringAsFixed(2)}',
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  Card(
                    child: ListTile(
                      title: const Text(
                        'Total Expenses',
                      ),
                      subtitle: Text(
                        '₹${state.totalExpenses.toStringAsFixed(2)}',
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  Card(
                    child: ListTile(
                      title: const Text(
                        'Transactions',
                      ),
                      subtitle: Text(
                        '${state.transactions.length}',
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  const Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  if (recentTransactions
                      .isEmpty)
                    const Text(
                      'No transactions yet',
                    )
                  else
                    ...recentTransactions
                        .map(
                      (
                        transaction,
                      ) {
                        return Card(
                          child: ListTile(
                            title: Text(
                              transaction
                                  .merchant,
                            ),
                            subtitle:
                                Text(
                              transaction
                                  .category,
                            ),
                            trailing:
                                Text(
                              '₹${transaction.amount.toStringAsFixed(2)}',
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