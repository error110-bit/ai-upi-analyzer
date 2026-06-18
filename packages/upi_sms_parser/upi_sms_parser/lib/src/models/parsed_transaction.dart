import 'transaction_type.dart';

class ParsedTransaction {
  final double amount;

  final String merchant;

  final DateTime timestamp;

  final TransactionType type;

  const ParsedTransaction({
    required this.amount,
    required this.merchant,
    required this.timestamp,
    required this.type,
  });

  @override
  String toString() {
    return '''
ParsedTransaction(
 amount: $amount,
 merchant: $merchant,
 timestamp: $timestamp,
 type: $type
)
''';
  }
}