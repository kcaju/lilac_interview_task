import 'package:flutter/foundation.dart';
import 'package:lilac_interview_task/controller/database_helper.dart';
import 'package:lilac_interview_task/model/credit_model.dart';
import 'package:lilac_interview_task/model/transaction_model.dart';

class ExpenseProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  List<TransactionModel> _transactions = [];
  List<CreditModel> _credits = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<TransactionModel> get transactions => _transactions;
  List<CreditModel> get credits => _credits;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  ExpenseProvider() {
    loadAllData();
  }

  // ===================== CALCULATIONS =====================

  double get totalIncome {
    return _transactions
        .where((t) => t.isIncome)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalExpense {
    return _transactions
        .where((t) => !t.isIncome)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalBalance {
    return totalIncome - totalExpense;
  }

  double get dailyAverage {
    if (_transactions.isEmpty) return 0.0;
    return (totalExpense > 0 ? totalExpense / 7 : totalIncome / 30);
  }

  double get weeklyTotal {
    return totalExpense;
  }

  // ===================== LOAD DATA =====================

  Future<void> loadAllData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _transactions = await _dbHelper.getAllTransactions();
      _credits = await _dbHelper.getAllCredits();
    } catch (e) {
      _errorMessage = 'Failed to load data from database: $e';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ===================== TRANSACTION CRUD =====================

  Future<bool> addTransaction(TransactionModel transaction) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _dbHelper.insertTransaction(transaction);
      _transactions = await _dbHelper.getAllTransactions();
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = 'Failed to save transaction: $e';
      debugPrint(_errorMessage);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateTransaction(TransactionModel transaction) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _dbHelper.updateTransaction(transaction);
      _transactions = await _dbHelper.getAllTransactions();
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update transaction: $e';
      debugPrint(_errorMessage);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteTransaction(int id) async {
    try {
      await _dbHelper.deleteTransaction(id);
      _transactions = await _dbHelper.getAllTransactions();
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete transaction: $e';
      debugPrint(_errorMessage);
      notifyListeners();
      return false;
    }
  }

  // ===================== CREDIT CRUD =====================

  Future<bool> addCredit(CreditModel credit) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _dbHelper.insertCredit(credit);
      _credits = await _dbHelper.getAllCredits();
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = 'Failed to save credit: $e';
      debugPrint(_errorMessage);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteCredit(int id) async {
    try {
      await _dbHelper.deleteCredit(id);
      _credits = await _dbHelper.getAllCredits();
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete credit: $e';
      debugPrint(_errorMessage);
      notifyListeners();
      return false;
    }
  }

  // ===================== CLEAR STORAGE =====================

  Future<bool> clearAllStorage() async {
    try {
      _isLoading = true;
      notifyListeners();

      await _dbHelper.clearAllData();
      _transactions = [];
      _credits = [];
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = 'Failed to clear storage: $e';
      debugPrint(_errorMessage);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
