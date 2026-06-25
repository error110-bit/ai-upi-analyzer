import '../../transactions/models/category_spending.dart';
import '../../transactions/models/transaction.dart';

class InsightGenerator {
  static String generateInsight({
   required List<Transaction> transactions,
   required List<CategorySpending> categorySpendings,
  }) {
   if (transactions.isEmpty) {
     return 'Import your SMS to receive personalized spending insights.';
   }

   if (categorySpendings.isEmpty) {
     return 'No expense data available yet.';
   }

   final highestCategory =
       categorySpendings.reduce(
     (a, b) =>
         a.amount > b.amount
             ? a
             : b,
   );

   final totalSpent =
       categorySpendings.fold(
     0.0,
     (sum, category) =>
         sum + category.amount,
   );

   final percentage =
       (highestCategory.amount /
               totalSpent) *
           100;

   return 'You spent ${percentage.toStringAsFixed(0)}% of your expenses on ${highestCategory.category}. Consider setting a budget for this category to improve your monthly savings.';
  }
}