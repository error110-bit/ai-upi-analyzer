import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../transactions/bloc/dashboard_bloc.dart';
import '../../transactions/bloc/dashboard_state.dart';
import '../services/insight_generator.dart';
import '../widgets/insight_card.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Insights',
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

            final insight =
                InsightGenerator
                    .generateInsight(
              transactions:
                  state.transactions,
              categorySpendings:
                  state.categorySpendings,
            );

            final highestCategory =
                state.categorySpendings.isEmpty
                    ? 'No Data'
                    : state.categorySpendings
                        .reduce(
                          (a, b) =>
                              a.amount > b.amount
                                  ? a
                                  : b,
                        )
                        .category;

            return SingleChildScrollView(
              padding:
                  const EdgeInsets.all(
                16,
              ),
              child: Column(
                children: [

                  InsightCard(
                    insight:
                        insight,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Card(
                    child: ListTile(
                      leading:
                          const Icon(
                        Icons
                            .trending_up,
                      ),
                      title: const Text(
                        'Highest Spending Category',
                      ),
                      subtitle:
                          Text(
                        highestCategory,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  Card(
                    child: ListTile(
                      leading:
                          const Icon(
                        Icons
                            .savings,
                      ),
                      title: const Text(
                        'Savings Suggestion',
                      ),
                      subtitle:
                          const Text(
                        'Try reducing expenses in your highest spending category to improve your monthly savings.',
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  Card(
                    child: ListTile(
                      leading:
                          const Icon(
                        Icons
                            .lightbulb,
                      ),
                      title: const Text(
                        'Spending Behaviour',
                      ),
                      subtitle:
                          Text(
                        state.totalExpenses >
                                state.totalIncome
                            ? 'Your expenses are higher than your income.'
                            : 'Your spending appears to be under control.',
                      ),
                    ),
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