import '../models/parsed_transaction.dart';

class UpiParser {
  static ParsedTransaction? parse(String sms) {
    // Extract amount
    final amountRegex =
        RegExp(r'(?:Rs\.?|INR|₹)\s*(\d+(?:\.\d+)?)');

    final amountMatch =
        amountRegex.firstMatch(sms);

    if (amountMatch == null) {
      return null;
    }

    final amount =
        double.parse(amountMatch.group(1)!);

    // Detect transaction type
    final lowerSms = sms.toLowerCase();

    final isExpense =
        lowerSms.contains('paid') ||
        lowerSms.contains('debited');

    // Extract merchant/person
    String merchant = 'Unknown';

    final merchantRegex =
        RegExp(r'(?:to|from)\s+([A-Za-z0-9\s]+)');

    final merchantMatch =
        merchantRegex.firstMatch(sms);

    if (merchantMatch != null) {
      merchant =
          merchantMatch.group(1)!.trim();
    }

    return ParsedTransaction(
      amount: amount,
      merchant: merchant,
      isExpense: isExpense,
    );
  }
}