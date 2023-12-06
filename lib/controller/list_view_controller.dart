import 'package:sqflite/sqflite.dart';

class ListViewController {
  List myList = [];
  static late Database database;
  static initializeDb() async {
    database = await openDatabase(
      "mydb.db",
      version: 1,
      onCreate: (Database db, int version) async {
        await db
            .execute('CREATE TABLE Title(id INTEGER PRIMARY KEY, name TEXT)');
      },
    );
  }

  addData({required String title}) async {
    await database.rawInsert('INSERT INTO Title(name) VALUES(?)', [title]);
  }

  getData() async {
    myList = await database.rawQuery('SELECT * FROM Title');
    print(myList);
  }

  deleteData({required int id}) async {
    await database.rawDelete('DELETE FROM Title WHERE id = ?', [id]);
  }

  updateData({required String title, required int id}) async {
    await database
        .rawUpdate('UPDATE Title SET name = ? WHERE id = ?', [title, id]);
  }
}
