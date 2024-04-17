import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'leadDataModel.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'lead_details.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE lead_details (
      id INTEGER PRIMARY KEY,
      additional_phone_number TEXT,
      email TEXT,
      date_of_birth TEXT,
      nationality TEXT,
      address_line_1 TEXT,
      address_line_2 TEXT,
      address_line_3 TEXT,
      city TEXT,
      land_mark TEXT,
      lead_amount TEXT,
      monthly_income TEXT,
      aadhar_number TEXT,
      pan_number TEXT,
      visit_Id TEXT,
      gender TEXT,
      state TEXT,
      pincode TEXT,
      district TEXT,
      post_office TEXT,
      residential_type TEXT,
      residential_status TEXT,
      product_category TEXT,
      product TEXT,
      customer_profile TEXT,
      employee_category TEXT,
      is_kycchecked INTEGER,
      is_crifchecked INTEGER
    )
  ''');
  }

  Future<int> insertData(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('lead_details', row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query('lead_details');
  }
  Future<LeadDataModel?> getFormDataByVisitId(String visitId) async {
    final Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      'lead_details',
      where: 'visit_Id = ?',
      whereArgs: [visitId],
    );
    if (maps.isNotEmpty) {
      return LeadDataModel.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateFormDataByVisitId(String visitId, LeadDataModel newData) async {
    final Database db = await instance.database;
    return await db.update(
      'lead_details',
      newData.toMap(),
      where: 'visit_Id = ?',
      whereArgs: [visitId],
    );
  }
// Add other CRUD operations as needed
}
