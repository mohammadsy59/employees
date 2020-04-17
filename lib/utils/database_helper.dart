import 'package:employees/model/employee.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Create Class DatabaseHelper
class DatabaseHelper {
  final String tableEmployee = 'employeeTable';
  final String columnId = 'id';
  final String columnAge = 'age';
  final String columnName = 'name';
  final String columnDepartment = 'department';
  final String columnCity = 'city';
  final String columnDescription = 'description';

//  Make the database Static

  static Database _db;

// Create Future to get info from Database with IF statment to find if
// the database is already existed and return it
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

// Create method to initialte th database
  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'employees.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }
  void _onCreate(Database db , int newVersion) async{
    var sql = 'CREATE TABLE $tableEmployee ($columnId INTEGER PRIMARY KEY,'
        '$columnAge TEXT ,$columnName TEXT ,'
        '$columnCity TEXT ,$columnDepartment TEXT ,$columnDescription TEXT )';
    await db.execute(sql);
  }

  Future<int> saveEmployee(Employee employee) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableEmployee, employee.toMap());
    return result;
  }

  Future<List> getAllEmployees() async {
    var dbClient = await db;
    var result = await dbClient.query(
        tableEmployee, columns: [columnId, columnAge, columnCity,
      columnDepartment, columnDescription, columnName]);
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableEmployee '));
  }

  Future<Employee> getEmployee(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableEmployee,
        columns: [
          columnId,
          columnName,
          columnAge,
          columnDepartment,
          columnCity,
          columnDescription
        ],
        where: '$columnId = ?', whereArgs: ['id']);
    if (result.length > 0) {
      return Employee.fromMap(result.first);
    }

    return null;
  }

  Future<int> updateEmployee(Employee employee) async {
    var dbClient = await db;
    return await dbClient.update(
        tableEmployee, employee.toMap(), where: '$columnId = ?',
        whereArgs: [employee.id]);
  }

  Future<int> deleteEmployee(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
        tableEmployee, where: '$columnId = ?', whereArgs: [id]);
  }
  Future close() async{
    var dbClient = await db;
    return dbClient.close();
  }


}