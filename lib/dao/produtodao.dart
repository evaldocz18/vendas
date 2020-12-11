import 'package:app/db/dbhelper.dart';
import 'package:app/model/produto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class ProdutoCubitDAO extends Cubit<List<Produto>> {
  ProdutoCubitDAO() : super(null) {
    _updateState();
  }

  _updateState() async {
    emit(await getAll());
  }

  Future<void> insertAllProduto(List<Produto> clientes) async {
    clientes.forEach((element) => insertProduto(element));
  }

  Future<void> insertProduto(Produto produto) async {
    Database db = await DBHelper.getInstance();
    await db.insert('produto', produto.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    _updateState();
  }

  Future<Produto> getProduto(int id) async {
    Database db = await DBHelper.getInstance();
    List<Map> maps =
        await db.query('produto', where: 'idProduto = ?', whereArgs: [id]);

    if (maps.length > 0) {
      return Produto.fromJson(maps.first);
    }
    return null;
  }

  Future<List<Produto>> getAll() async {
    Database db = await DBHelper.getInstance();
    List<Map> result = await db.rawQuery('SELECT * FROM produto');
    return result.map((e) => Produto.fromJson(e)).toList();
  }

  Future<int> delete(int id) async {
    Database db = await DBHelper.getInstance();
    int c = await db.delete('produto', where: 'idProduto = ?', whereArgs: [id]);
    _updateState();
    return c;
  }

  Future<int> update(Produto produto) async {
    Database db = await DBHelper.getInstance();
    int c = await db.update('produto', produto.toJson(),
        where: 'idProduto = ?', whereArgs: [produto.idProduto]);
    _updateState();
    return c;
  }

  Future<void> deleteAllProdutos() async {
    Database db = await DBHelper.getInstance();
    await db.delete('produto');
    _updateState();
  }
}
