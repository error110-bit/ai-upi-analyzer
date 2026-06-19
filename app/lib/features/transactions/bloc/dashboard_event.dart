import 'package:equatable/equatable.dart';
import '../models/transaction.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class FetchDashboardData extends DashboardEvent {
  const FetchDashboardData();
}

class RefreshDashboard extends DashboardEvent {
  const RefreshDashboard();
}

class ImportSms extends DashboardEvent {
  const ImportSms();
}

class DeleteTransaction extends DashboardEvent {
  final String transactionId;

  const DeleteTransaction(
    this.transactionId,
  );

  @override
  List<Object?> get props => [
        transactionId,
      ];
}

class AddTransaction
    extends DashboardEvent {
  final Transaction transaction;

  const AddTransaction(
    this.transaction,
  );

  @override
  List<Object?> get props => [
        transaction,
      ];
}