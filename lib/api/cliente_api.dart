import 'dart:convert';

import 'package:app/model/cliente.dart';
import 'package:http/http.dart' as http;

class ClienteAPI {
  static Future<List<Cliente>> getAllClientes() async {
    var url = 'http://wfrsistemas.net.br/sites/testemobileapi/cliente';
    var response = await http.get(url);

    if (response.statusCode != 200) return null;

    var data = response.body.replaceAll(RegExp(r'<[^>]*>'), '');
    data = data.replaceAll(RegExp(r'\\"'), '"');
    data = data.substring(1, data.length - 1);

    List<dynamic> dataList = jsonDecode(data);
    return dataList.map((e) => Cliente.fromJson(e)).toList();
  }
}
