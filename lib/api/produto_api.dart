import 'dart:convert';

import 'package:app/model/produto.dart';
import 'package:http/http.dart' as http;

class ProdutoAPI {
  static Future<List<Produto>> getAll() async {
    var url = 'http://wfrsistemas.net.br/sites/testemobileapi/produto';
    var response = await http.get(url);

    if (response.statusCode != 200) return null;

    var data = response.body.replaceAll(RegExp(r'<[^>]*>'), '');
    data = data.replaceAll(RegExp(r'\\"'), '"');
    data = data.substring(1, data.length - 1);

    List<dynamic> dataList = jsonDecode(data);

    return dataList.map((e) => Produto.fromJson(e)).toList();
  }
}
