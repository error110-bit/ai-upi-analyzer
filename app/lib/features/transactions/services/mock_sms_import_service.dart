import '../models/transaction.dart';
import 'sms_import_service.dart';

class MockSmsImportService
    implements SmsImportService {
  @override
  Future<List<Transaction>>
      importTransactions() async {
    return [
      Transaction(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),
        amount: 450,
        merchant: 'Swiggy',
        timestamp: DateTime.now(),
        type: TransactionType.expense,
        category: 'Food',
      ),
      Transaction(
        id: (DateTime.now()
                    .millisecondsSinceEpoch +
                1)
            .toString(),
        amount: 120,
        merchant: 'Uber',
        timestamp: DateTime.now(),
        type: TransactionType.expense,
        category: 'Travel',
      ),
    ];
  }
}