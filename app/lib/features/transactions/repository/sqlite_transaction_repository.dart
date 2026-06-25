import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/transaction.dart' as models;
import 'transaction_repository.dart';

class SQLiteTransactionRepository
    implements TransactionRepository {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = join(
      await getDatabasesPath(),
      'upi_analyzer.db',
    );

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (
        db,
        version,
      ) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS transactions(
            id TEXT PRIMARY KEY,
            amount REAL,
            merchant TEXT,
            timestamp TEXT,
            type TEXT,
            category TEXT
          )
        ''');
       },
      );
  }

  @override
  Future<void> saveTransaction(
    models.Transaction transaction,
  ) async {
    final db = await database;

    await db.insert(
      'transactions',
      transaction.toJson(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  @override
  Future<void> saveTransactions(
    List<models.Transaction> transactions,
  ) async {
    for (final transaction
        in transactions) {
      await saveTransaction(
        transaction,
      );
    }
  }

  @override
  Future<List<models.Transaction>>
      getAllTransactions() async {
    final db = await database;

    final result = await db.query(
      'transactions',
    );

    return result
        .map(
          (json) =>
              models.Transaction.fromJson(
            json,
          ),
        )
        .toList();
  }

  @override
  Future<void> updateTransaction(
    models.Transaction transaction,
  ) async {
    final db = await database;

    await db.update(
      'transactions',
      transaction.toJson(),
      where: 'id = ?',
      whereArgs: [
        transaction.id,
      ],
    );
  }

  @override
  Future<void> deleteTransaction(
    String id,
  ) async {
    final db = await database;

    await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}