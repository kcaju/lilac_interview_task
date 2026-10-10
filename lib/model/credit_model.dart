class CreditModel {
  final int? id;
  final String creditType;
  final String to;
  final String date;
  final String planType;
  final double amount;
  final String dueInfo;

  const CreditModel({
    this.id,
    required this.creditType,
    required this.to,
    required this.date,
    required this.planType,
    required this.amount,
    required this.dueInfo,
  });

  static DateTime? parseCreditDate(String dateStr) {
    if (dateStr.isEmpty) return null;
    final iso = DateTime.tryParse(dateStr);
    if (iso != null) return iso;

    final slashMatch = RegExp(r'(\d{1,2})/(\d{1,2})/(\d{2,4})').firstMatch(dateStr);
    if (slashMatch != null) {
      final d = int.tryParse(slashMatch.group(1)!);
      final m = int.tryParse(slashMatch.group(2)!);
      var y = int.tryParse(slashMatch.group(3)!);
      if (d != null && m != null && y != null) {
        if (y < 100) y += 2000;
        return DateTime(y, m, d);
      }
    }

    const months = {
      'jan': 1, 'feb': 2, 'mar': 3, 'apr': 4, 'may': 5, 'jun': 6,
      'jul': 7, 'aug': 8, 'sep': 9, 'oct': 10, 'nov': 11, 'dec': 12
    };
    final textMatch = RegExp(r'(\d{1,2})\s+([a-zA-Z]{3,})\s+(\d{4})').firstMatch(dateStr);
    if (textMatch != null) {
      final d = int.tryParse(textMatch.group(1)!);
      final monthName = textMatch.group(2)!.toLowerCase();
      final y = int.tryParse(textMatch.group(3)!);
      final m = months[monthName.substring(0, 3)];
      if (d != null && m != null && y != null) {
        return DateTime(y, m, d);
      }
    }
    return null;
  }

  bool get isDueToday {
    final dt = parseCreditDate(date);
    if (dt != null) {
      final now = DateTime.now();
      return dt.year == now.year && dt.month == now.month && dt.day == now.day;
    }
    return dueInfo.toLowerCase().contains('today');
  }

  String get formattedDueInfo {
    final dt = parseCreditDate(date);
    if (dt != null) {
      final now = DateTime.now();
      final isToday = dt.year == now.year && dt.month == now.month && dt.day == now.day;
      if (isToday) {
        return 'Due Today';
      } else {
        final d = dt.day.toString().padLeft(2, '0');
        final m = dt.month.toString().padLeft(2, '0');
        final y = dt.year.toString().substring(2);
        return 'Due On $d/$m/$y';
      }
    }
    return dueInfo.isNotEmpty ? dueInfo : 'Due Today';
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'credit_type': creditType,
      'to_person': to,
      'date': date,
      'plan_type': planType,
      'amount': amount,
      'due_info': dueInfo,
    };
  }

  factory CreditModel.fromMap(Map<String, dynamic> map) {
    return CreditModel(
      id: map['id'] as int?,
      creditType: map['credit_type'] as String? ?? 'Subscriptions',
      to: map['to_person'] as String? ?? '',
      date: map['date'] as String? ?? '',
      planType: map['plan_type'] as String? ?? 'Monthly',
      amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
      dueInfo: map['due_info'] as String? ?? '',
    );
  }

  CreditModel copyWith({
    int? id,
    String? creditType,
    String? to,
    String? date,
    String? planType,
    double? amount,
    String? dueInfo,
  }) {
    return CreditModel(
      id: id ?? this.id,
      creditType: creditType ?? this.creditType,
      to: to ?? this.to,
      date: date ?? this.date,
      planType: planType ?? this.planType,
      amount: amount ?? this.amount,
      dueInfo: dueInfo ?? this.dueInfo,
    );
  }
}
