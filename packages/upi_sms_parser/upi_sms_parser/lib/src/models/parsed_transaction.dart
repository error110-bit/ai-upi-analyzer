class ParsedTransaction {
  final double amount;
  final String merchant;
  final bool isExpense;

  const ParsedTransaction({
    required this.amount,
    required this.merchant,
    required this.isExpense,
  });
}