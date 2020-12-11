import 'package:app/db/dbhelper.dart';
import 'package:app/model/cliente.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class ClienteCubitDAO extends Cubit<List<Cliente>> {
  ClienteCubitDAO() : super(null) {
    _updateState();
  }

  _updateState() async {
    emit(await getAllCliente());
  }

  Future<void> inserAllCliente(List<Cliente> clientes) async {
    clientes.forEach((element) => insertCliente(element));
  }

  Future<void> insertCliente(Cliente cliente) async {
    Database db = await DBHelper.getInstance();
    await db.insert('cliente', cliente.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    _updateState();
  }

  Future<Cliente> getCliente(int id) async {
    Database db = await DBHelper.getInstance();
    List<Map> maps =
        await db.query('cliente', where: 'idCliente = ?', whereArgs: [id]);

    if (maps.length > 0) {
      return Cliente.fromJson(maps.first);
    }
    return null;
  }

  Future<List<Cliente>> getAllCliente() async {
    Database db = await DBHelper.getInstance();
    List<Map> result = await db.rawQuery('SELECT * FROM cliente');
    return result.map((e) => Cliente.fromJson(e)).toList();
  }

  Future<int> deleteCliente(int id) async {
    Database db = await DBHelper.getInstance();
    int c = await db.delete('cliente', where: 'idCliente = ?', whereArgs: [id]);
    _updateState();
    return c;
  }

  Future<int> updateCliente(Cliente cliente) async {
    Database db = await DBHelper.getInstance();
    int c = await db.update('cliente', cliente.toJson(),
        where: 'idCliente = ?', whereArgs: [cliente.idCliente]);
    _updateState();
    return c;
  }

  Future<void> deleteAllClientes() async {
    Database db = await DBHelper.getInstance();
    await db.delete('cliente');
    _updateState();
  }
}
