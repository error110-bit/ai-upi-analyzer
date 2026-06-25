import '../models/parsed_transaction.dart';
import '../models/transaction_type.dart';

class UpiParser {
  static ParsedTransaction? parse(
    String sms,
    DateTime timestamp,
  ) {
    final amount = _extractAmount(sms);

    if (amount == null) {
      return null;
    }

    final type = _detectType(sms);

    if (type == null) {
      return null;
    }

    final merchant = _extractMerchant(sms);

    if (merchant == null) {
      return null;
    }

    return ParsedTransaction(
      amount: amount,
      merchant: merchant,
      timestamp: timestamp,
      type: type,
    );
  }

  static double? _extractAmount(
    String sms,
  ) {
    final regex = RegExp(
      r'(?:Rs\.?|INR|₹)\s*([\d,]+(?:\.\d+)?)',
      caseSensitive: false,
    );

    final match = regex.firstMatch(sms);

    if (match == null) {
      return null;
    }

    final amountString =
        match.group(1)!.replaceAll(',', '');

    return double.parse(amountString);
  }

  static TransactionType? _detectType(
    String sms,
  ) {
    final lowerSms = sms.toLowerCase();

    if (lowerSms.contains('paid') ||
        lowerSms.contains('debited') ||
        lowerSms.contains('sent')) {
      return TransactionType.expense;
    }

    if (lowerSms.contains('received') ||
        lowerSms.contains('credited')) {
      return TransactionType.income;
    }

    return null;
  }

  static String? _extractMerchant(
    String sms,
  ) {
    final lowerSms = sms.toLowerCase();

    String? merchant;

    if (lowerSms.contains('paid to')) {
      merchant = sms.split(
        RegExp(
          r'paid to',
          caseSensitive: false,
        ),
      )[1];
    } else if (lowerSms.contains('sent to')) {
      merchant = sms.split(
        RegExp(
          r'sent to',
          caseSensitive: false,
        ),
      )[1];
    } else if (lowerSms.contains('received from')) {
      merchant = sms.split(
        RegExp(
          r'received from',
          caseSensitive: false,
        ),
      )[1];
    } else if (lowerSms.contains('credited from')) {
      merchant = sms.split(
        RegExp(
          r'credited from',
          caseSensitive: false,
        ),
      )[1];
    }

    if (merchant == null) {
      final creditedMatch = RegExp(
        r';\s*([A-Za-z ]+?)\s+credited',
        caseSensitive: false,
      ).firstMatch(sms);

      if (creditedMatch != null) {
        merchant = creditedMatch.group(1);
      }
    }

    if(merchant == null) {
      return null;
    }

    final viaIndex =
        merchant.toLowerCase().indexOf('via');

    if (viaIndex != -1) {
      merchant = merchant.substring(
        0,
        viaIndex,
      );
    }

    merchant = merchant.trim();

    return merchant.isEmpty
        ? null
        : merchant;
  }
}