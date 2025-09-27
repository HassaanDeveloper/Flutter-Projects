class Budget {
  final String id;
  final String category;
  final double amount;
  final DateTime period; // Monthly budget period

  Budget({
    required this.id,
    required this.category,
    required this.amount,
    required this.period,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'period': period.toIso8601String(),
    };
  }

  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'],
      category: map['category'],
      amount: map['amount'],
      period: DateTime.parse(map['period']),
    );
  }
}