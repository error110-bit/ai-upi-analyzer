class ParsedTransaction {
  final double amount;
  final String merchant;
  final bool isExpense;

  const ParsedTransaction({
    required this.amount,
    required this.merchant,
    required this.isExpense,
  });

  @override
  String toString() {
    return '''
ParsedTransaction(
 amount: $amount,
 merchant: $merchant,
 isExpense: $isExpense
)
''';
  }
}
