import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../insights/services/insight_generator.dart';
import '../../insights/widgets/insight_card.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/import_sms_card.dart';
import '../widgets/summary_cards.dart';
import '../widgets/recent_transaction.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'UPI Expense Analyzer',
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
                  state
                      .categorySpendings,
            );

            return SingleChildScrollView(

              padding:
                  const EdgeInsets.all(
                16,
              ),

              child: Column(
                crossAxisAlignment:
                   CrossAxisAlignment.start,
                children: [

                  const Text(
                   'Welcome',
                   style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                   ) ,
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  const Text(
                   'Track and analyze your UPI spending effortlessly.',
                   style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                   ),
                  ),

                  const SizedBox(
                   height: 24,
                 ),

                  ImportSmsCard(

                    onImport: () {

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Importing SMS...',
                          ),
                          duration: Duration(
                            seconds: 2,
                          ),
                        ),
                      );
                      context.read<DashboardBloc>().add(
                        const ImportSms(),
                      );
                    },
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  SummaryCards(

                    totalIncome:
                        state.totalIncome,

                    totalExpenses:
                        state.totalExpenses,

                    transactionCount:
                        state
                            .transactions
                            .length,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  InsightCard(
                    insight:
                        insight,
                  ),
                  const SizedBox(height:20,),
                  RecentTransactions(
                    transactions: state.transactions,
                    limit: 5,
                  )
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