import '../models/parsed_transaction.dart';

class UpiParser {
  static ParsedTransaction? parse(
    String sms,
    DateTime timestamp,
  ) {
    // TODO
    return null;
  }

  static double? _extractAmount(
    String sms,
  ) {
    return null;
  }

  static TransactionType? _detectType(
    String sms,
  ) {
    return null;
  }

  static String? _extractMerchant(
    String sms,
  ) {
    return null;
  }
}