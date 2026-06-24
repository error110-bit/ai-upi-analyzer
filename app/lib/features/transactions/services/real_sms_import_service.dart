import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upi_sms_parser/upi_sms_parser.dart';

import '../models/transaction.dart';
import 'sms_import_service.dart';
import 'transaction_categorizer.dart';

class RealSmsImportService
    implements SmsImportService {

  @override
  Future<List<Transaction>>
      importTransactions() async {
    throw UnimplementedError();
  }

  Future<void>
      _requestPermission() async {
    final status =
        await Permission.sms.status;

    if (!status.isGranted) {
      throw Exception(
          'SMS permission denied.');
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
    throw UnimplementedError();
  }
}

