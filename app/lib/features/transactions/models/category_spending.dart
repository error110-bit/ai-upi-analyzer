import 'package:equatable/equatable.dart';

class CategorySpending extends Equatable {
  final String category;
  final double amount;

  const CategorySpending({
    required this.category,
    required this.amount,
  });

  @override
  List<Object?> get props => [
        category,
        amount,
      ];
}