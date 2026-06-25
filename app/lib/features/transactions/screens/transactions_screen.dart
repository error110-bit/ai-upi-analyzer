import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../models/transaction.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transactions',
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
            if (state.transactions
                .isEmpty) {
              return const Center(
                child: Text(
                  'No transactions available',
                ),
              );
            }

            return ListView.builder(
              padding:
                  const EdgeInsets.all(
                16,
              ),
              itemCount:
                  state.transactions.length,
              itemBuilder:
                  (context, index) {
                final transaction =
                    state.transactions[index];

                return Card(
                  margin:
                      const EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        transaction.type ==
                                TransactionType
                                    .expense
                            ? Icons
                                .arrow_upward
                            : Icons
                                .arrow_downward,
                      ),
                    ),

                    title: Text(
                      transaction.merchant,
                    ),

                    subtitle: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Text(
                          transaction
                              .category,
                        ),
                        Text(
                          transaction
                              .timestamp
                              .toLocal()
                              .toString()
                              .split(
                                ' ',
                              )[0],
                        ),
                      ],
                    ),

                    trailing: Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,
                      children: [
                        Text(
                          '₹${transaction.amount.toStringAsFixed(2)}',
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        IconButton(
                          icon:
                              const Icon(
                            Icons.delete,
                            color:
                                Colors.red,
                          ),
                          onPressed: () {
                            context
                                .read<
                                    DashboardBloc>()
                                .add(
                                  DeleteTransaction(
                                    transaction
                                        .id,
                                  ),
                                );
                            ScaffoldMessenger.of(
                                    context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Transaction deleted',
                                ),
                                duration:
                                    Duration(
                                  seconds: 2,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}