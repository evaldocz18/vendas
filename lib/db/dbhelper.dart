import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database _db;

  DBHelper._();

  static Future<Database> getInstance() async {
    if (_db == null) {
      _db = await openDatabase('database.db', version: 1, onCreate: _createDB);
    }
    return _db;
  }

  static _createDB(Database db, int version) async {
    await db.execute(
        'create table cliente (idCliente integer primary key, nmCliente text, Cidade text)');
    await db.execute(
        'create table produto (idProduto integer primary key, dscProduto text, vlrUnitario real)');
    await db.execute(
        'create table venda (idVenda integer primary key, dthVenda text, idCliente integer, idProduto integer, qtdVenda integer, vlrUnitarioVenda real)');
  }

  Future close() async => _db.close();
}
