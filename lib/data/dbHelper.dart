import 'package:flutter_sqflite_app/models/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database _db;

  Future get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }
  Future initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "etrade.db");
    var eTradeDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return eTradeDb;
  }
  void createDb(Database db, int version) async {
    await db.execute(
        "Create table products(id integer primary key, name text, description text, unitPrice integer)");
  }
  Future getProducts()async{
    Database db =await this.db;
    var result =await db.query("products");
    return List.generate(result.length, (i) {
      return Product.fromObject(result[i]);
    });
  }
// ignore: missing_return
  Future insert (Product product) async{
    Database db =await this.db;
    return await db.insert("products", product.toMap());
  }
  Future delete (int id) async{
    Database db =await this.db;
    var result = await db.rawDelete("delete from products where id=$id" );
    return result;
  }
  Future update (Product product) async{
    Database db = await this.db;
    var result = await db.update("products", product.toMap(), where: "id = ?", whereArgs: [product.id]);
    return result;

  }

}