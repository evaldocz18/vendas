import 'package:app/dao/produtodao.dart';
import 'package:app/model/produto.dart';
import 'package:app/pages/produto/produto_cad_page.dart';
import 'package:app/pages/produto/produto_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProdutoPage extends StatefulWidget {
  @override
  _ProdutoPageState createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  bool campoTexto = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produto"),
        centerTitle: true,
        actions: <Widget>[
          //
          //
          if (campoTexto == true)
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  campoTexto = false;
                });
              },
            ),
          //
          //
          if (campoTexto == true) appBar(),
          //
          //
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                campoTexto = true;
              });
            },
          ),

          IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () async {
                BlocProvider.of<ProdutoCubitDAO>(context).deleteAllProdutos();
              }),
        ],
      ),

      //Container para carregar a lista de clientes
      body: _body(),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Produto produto;
          produto = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroProdutoPage()),
          );
          if (produto != null) {
            BlocProvider.of<ProdutoCubitDAO>(context).insertProduto(produto);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget appBar() {
    return Expanded(
      child: TextFormField(
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: 20),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.black38),
          hintText: "Pesquisar Produto",
        ),
      ),
    );
  }

  _body() {
    return BlocBuilder<ProdutoCubitDAO, List<Produto>>(
        builder: (context, listaProduto) {
      if (listaProduto != null) {
        return ListView.builder(
          itemCount: listaProduto.length,
          itemBuilder: (_, index) {
            return ListTile(
              title: Text(listaProduto[index].dscProduto),
              subtitle: Text(listaProduto[index].vlrUnitario.toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProdutoPage(
                                    produto: listaProduto[index],
                                  )),
                        );
                      }),
                ],
              ),
            );
          },
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
