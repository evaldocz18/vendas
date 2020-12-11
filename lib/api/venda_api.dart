import 'dart:convert';

import 'package:app/model/venda.dart';
import 'package:http/http.dart' as http;

class VendaAPI {
  static Future<List<Venda>> getAll() async {
    var url = 'http://wfrsistemas.net.br/sites/testemobileapi/venda';
    var response = await http.get(url);

    if (response.statusCode != 200) return null;

    var data = response.body.replaceAll(RegExp(r'<[^>]*>'), '');
    data = data.replaceAll(RegExp(r'\\"'), '"');
    data = data.substring(1, data.length - 1);

    List<dynamic> dataList = jsonDecode(data);

    return dataList.map((e) => Venda.fromJson(e)).toList();
  }
}
