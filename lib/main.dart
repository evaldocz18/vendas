import 'package:app/api/cliente_api.dart';
import 'package:app/api/produto_api.dart';
import 'package:app/api/venda_api.dart';
import 'package:app/dao/clientedao.dart';
import 'package:app/dao/vendadao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dao/produtodao.dart';
import 'pages/tabs_pages.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ClienteCubitDAO>(create: (BuildContext context) {
        ClienteCubitDAO cubit = ClienteCubitDAO();
        ClienteAPI.getAllClientes().then(cubit.inserAllCliente);

        

        return cubit;
      }),
      //
      BlocProvider<ProdutoCubitDAO>(create: (BuildContext context) {
        ProdutoCubitDAO cubit = ProdutoCubitDAO();
        ProdutoAPI.getAll().then(cubit.insertAllProduto);
        return cubit;
      }),
      //
      BlocProvider<VendaCubitDAO>(create: (BuildContext context) {
        VendaCubitDAO cubit = VendaCubitDAO();
        VendaAPI.getAll().then(cubit.insertAllVenda);
        return cubit;
      }),
      //
    ],
    child: MaterialApp(
      home: TabsScreen(),
    ),
  ));
}
