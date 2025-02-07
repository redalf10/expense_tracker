import 'dart:convert';
import 'package:expense_tracker/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transaction = [];

  List<TransactionModel> get transaction => _transaction;

  TransactionProvider() {
    loadTransactions(); // Load transactions when provider initializes
  }

  double get totalIncome => _transaction
      .where((tx) => tx.isIncome)
      .fold(0, (sum, tx) => sum + tx.amount);

  double get totalExpense => _transaction
      .where((tx) => !tx.isIncome)
      .fold(0, (sum, tx) => sum + tx.amount);

  double get remainingBalance => totalIncome - totalExpense;

  void addTransaction(String title, double amount, bool isIncome) {
    final newTransaction = TransactionModel(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
      isIncome: isIncome,
    );
    _transaction.insert(0, newTransaction);
    _saveTransactions(); // Save after adding
    notifyListeners();
  }

  void removeTransaction(String id) {
    _transaction.removeWhere((x) => x.id == id);
    _saveTransactions(); // Save after deleting
    notifyListeners();
  }

  Future<void> _saveTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final transactionList =
        _transaction.map((tx) => json.encode(tx.toMap())).toList();
    prefs.setStringList('transactions', transactionList);
  }

  Future<void> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? storedTransactions =
        prefs.getStringList('transactions');

    if (storedTransactions != null) {
      _transaction = storedTransactions
          .map((tx) => TransactionModel.fromMap(json.decode(tx)))
          .toList();
      notifyListeners();
    }
  }
}
