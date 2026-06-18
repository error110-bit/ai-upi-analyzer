import '../models/transaction.dart';

abstract class TransactionRepository {
  Future<void> saveTransaction(
    Transaction transaction,
  );

  Future<void> saveTransactions(
    List<Transaction> transactions,
  );

  Future<List<Transaction>>
      getAllTransactions();

  Future<void> updateTransaction(
    Transaction transaction,
  );

  Future<void> deleteTransaction(
    String id,
  );
}