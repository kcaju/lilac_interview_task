class TransactionModel {
  final int? id;
  final String type; // 'Expense' or 'Income'
  final String name;
  final double amount;
  final String date;
  final String? createdAt;

  const TransactionModel({
    this.id,
    required this.type,
    required this.name,
    required this.amount,
    required this.date,
    this.createdAt,
  });

  bool get isIncome => type.toLowerCase() == 'income';

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'type': type,
      'name': name,
      'amount': amount,
      'date': date,
      'created_at': createdAt ?? DateTime.now().toIso8601String(),
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as int?,
      type: map['type'] as String? ?? 'Expense',
      name: map['name'] as String? ?? '',
      amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
      date: map['date'] as String? ?? '',
      createdAt: map['created_at'] as String?,
    );
  }

  TransactionModel copyWith({
    int? id,
    String? type,
    String? name,
    double? amount,
    String? date,
    String? createdAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
