import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:falguni_upi_sms_parser/falguni_upi_sms_parser.dart' as upi_parser;

import '../models/transaction.dart';
import 'sms_import_service.dart';
import 'transaction_categorizer.dart';

class RealSmsImportService
    implements SmsImportService {

  @override
  Future<List<Transaction>>
      importTransactions() async {

    await _requestPermission();

    final messages =
        await _getRecentMessages();

    final transactions =
        _convertToTransactions(
          messages,
        );

    return transactions;
  }

  Future<void>
      _requestPermission() async {
    var status =
        await Permission.sms.status;

    if (!status.isGranted) {
      status = await Permission.sms.request();
    }
    if (status.isPermanentlyDenied) {
      await openAppSettings();

      throw Exception(
        'SMS permission is permanently denied. Please enable it in settings.',
      );  
    }

    if(!status.isGranted) {
      throw Exception(
        'SMS permission is required to import transactions.',
      );
    }
  }

  Future<List<SmsMessage>>
     _getRecentMessages() async {

    final smsQuery = SmsQuery();

    final allMessages =
        await smsQuery.getAllSms;

    final cutoffDate =
        DateTime.now().subtract(
      const Duration(
        days: 90,
      ),
    );

    final recentMessages =
        allMessages.where(
      (sms) =>
          sms.date != null &&
          sms.date!.isAfter(
            cutoffDate,
          ),
    ).toList();

    return recentMessages;
  }

  List<Transaction>
     _convertToTransactions(
    List<SmsMessage> messages,
  ) {
    final transactions =
        <Transaction>[];

    for (final message in messages) {
      if (message.body == null ||
          message.date == null) {
        continue;
      }

      final parsed =
          upi_parser.UpiParser.parse(
        message.body!,
        message.date!,
      );

      if (parsed == null) {
        continue;
      }

      final category =
          TransactionCategorizer
              .categorize(
        parsed.merchant,
      );

      final transaction =
          Transaction(
        id: message.id.toString(),

        amount: parsed.amount,

        merchant:
            parsed.merchant,

        timestamp:
            parsed.timestamp,

        type: parsed.type.name == 'income'
            ? TransactionType.income
            : TransactionType.expense,

        category: category,
      );

      transactions.add(
        transaction,
      );
    }
    
    return transactions;
  }

   
}

