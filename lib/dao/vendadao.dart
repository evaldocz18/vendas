import 'package:app/db/dbhelper.dart';
import 'package:app/model/venda.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class VendaCubitDAO extends Cubit<List<Venda>> {
  VendaCubitDAO() : super(null) {
    _updateState();
  }

  _updateState() async {
    emit(await getAll());
  }

  Future<void> insertAllVenda(List<Venda> clientes) async {
    clientes.forEach((element) => insertVenda(element));
  }

  Future<void> insertVenda(Venda venda) async {
    Database db = await DBHelper.getInstance();
    await db.insert('venda', venda.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    _updateState();
  }

  Future<Venda> getVenda(int id) async {
    Database db = await DBHelper.getInstance();
    List<Map> maps =
        await db.query('venda', where: 'idVenda = ?', whereArgs: [id]);

    if (maps.length > 0) {
      return Venda.fromJson(maps.first);
    }
    return null;
  }

  Future<List<Venda>> getAll() async {
    Database db = await DBHelper.getInstance();
    List<Map> result = await db.rawQuery('SELECT * FROM venda');
    return result.map((e) => Venda.fromJson(e)).toList();
  }

  Future<int> delete(int id) async {
    Database db = await DBHelper.getInstance();
    int c = await db.delete('venda', where: 'idVenda = ?', whereArgs: [id]);
    _updateState();
    return c;
  }

  Future<int> update(Venda venda) async {
    Database db = await DBHelper.getInstance();
    int c = await db.update('venda', venda.toJson(),
        where: 'idVenda = ?', whereArgs: [venda.idVenda]);
    _updateState();
    return c;
  }

  Future<void> deleteAllVendas() async {
    Database db = await DBHelper.getInstance();
    await db.delete('venda');
    _updateState();
  }
}
