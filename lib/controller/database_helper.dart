import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:lilac_interview_task/model/credit_model.dart';
import 'package:lilac_interview_task/model/transaction_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('expenses_app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);

      return await openDatabase(
        path,
        version: 1,
        onCreate: _createDB,
      );
    } catch (e) {
      debugPrint('Database initialization error: $e');
      rethrow;
    }
  }

  Future<void> _createDB(Database db, int version) async {
    try {
      // Create Transactions Table
      await db.execute('''
        CREATE TABLE transactions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          type TEXT NOT NULL,
          name TEXT NOT NULL,
          amount REAL NOT NULL,
          date TEXT NOT NULL,
          created_at TEXT NOT NULL
        )
      ''');

      // Create Credits Table
      await db.execute('''
        CREATE TABLE credits (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          credit_type TEXT NOT NULL,
          to_person TEXT NOT NULL,
          date TEXT NOT NULL,
          plan_type TEXT NOT NULL,
          amount REAL NOT NULL,
          due_info TEXT NOT NULL
        )
      ''');

      // Clean database creation - No dummy seed data.
      // Data is only present when added to the database by user.
    } catch (e) {
      debugPrint('Database create table error: $e');
      rethrow;
    }
  }

  // ===================== TRANSACTION CRUD OPERATIONS =====================

  /// CREATE
  Future<int> insertTransaction(TransactionModel transaction) async {
    try {
      final db = await instance.database;
      return await db.insert(
        'transactions',
        transaction.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      debugPrint('Error inserting transaction: $e');
      rethrow;
    }
  }

  /// READ (ALL)
  Future<List<TransactionModel>> getAllTransactions() async {
    try {
      final db = await instance.database;
      final result = await db.query(
        'transactions',
        orderBy: 'id DESC',
      );
      return result.map((map) => TransactionModel.fromMap(map)).toList();
    } catch (e) {
      debugPrint('Error fetching transactions: $e');
      return [];
    }
  }

  /// READ (BY ID)
  Future<TransactionModel?> getTransactionById(int id) async {
    try {
      final db = await instance.database;
      final result = await db.query(
        'transactions',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (result.isNotEmpty) {
        return TransactionModel.fromMap(result.first);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching transaction by id: $e');
      return null;
    }
  }

  /// UPDATE
  Future<int> updateTransaction(TransactionModel transaction) async {
    try {
      final db = await instance.database;
      return await db.update(
        'transactions',
        transaction.toMap(),
        where: 'id = ?',
        whereArgs: [transaction.id],
      );
    } catch (e) {
      debugPrint('Error updating transaction: $e');
      rethrow;
    }
  }

  /// DELETE
  Future<int> deleteTransaction(int id) async {
    try {
      final db = await instance.database;
      return await db.delete(
        'transactions',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      debugPrint('Error deleting transaction: $e');
      rethrow;
    }
  }

  /// CLEAR ALL TRANSACTIONS
  Future<int> clearTransactions() async {
    try {
      final db = await instance.database;
      return await db.delete('transactions');
    } catch (e) {
      debugPrint('Error clearing transactions: $e');
      rethrow;
    }
  }

  // ===================== CREDIT CRUD OPERATIONS =====================

  /// CREATE
  Future<int> insertCredit(CreditModel credit) async {
    try {
      final db = await instance.database;
      return await db.insert(
        'credits',
        credit.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      debugPrint('Error inserting credit: $e');
      rethrow;
    }
  }

  /// READ (ALL)
  Future<List<CreditModel>> getAllCredits() async {
    try {
      final db = await instance.database;
      final result = await db.query('credits', orderBy: 'id DESC');
      return result.map((map) => CreditModel.fromMap(map)).toList();
    } catch (e) {
      debugPrint('Error fetching credits: $e');
      return [];
    }
  }

  /// DELETE
  Future<int> deleteCredit(int id) async {
    try {
      final db = await instance.database;
      return await db.delete(
        'credits',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      debugPrint('Error deleting credit: $e');
      rethrow;
    }
  }

  /// CLEAR ALL DATA (FOR PROFILE CLEAR STORAGE)
  Future<void> clearAllData() async {
    try {
      final db = await instance.database;
      await db.delete('transactions');
      await db.delete('credits');
    } catch (e) {
      debugPrint('Error clearing all database data: $e');
      rethrow;
    }
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }
}
