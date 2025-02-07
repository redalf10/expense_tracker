class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final bool isIncome;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.isIncome,
  });

  // Convert TransactionModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(), // Store date as String
      'isIncome': isIncome,
    };
  }

  // Convert a Map back to TransactionModel
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      date: DateTime.parse(map['date']), // Convert String back to DateTime
      isIncome: map['isIncome'],
    );
  }
}
