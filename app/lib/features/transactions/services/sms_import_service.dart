import '../models/transaction.dart';

abstract class SmsImportService {
  Future<List<Transaction>>
      importTransactions();
}