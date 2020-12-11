import 'package:app/model/produto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CadastroProdutoPage extends StatefulWidget {
  final Produto produto;

  CadastroProdutoPage({this.produto});

  @override
  _CadastroProdutoPageState createState() => _CadastroProdutoPageState();
}

class _CadastroProdutoPageState extends State<CadastroProdutoPage> {
  final _descController = TextEditingController();
  final _vlrUnitController = TextEditingController();

  final _nameFocus = FocusNode();

  bool _userEdited = false;
  Produto _editarContact;

  @override
  void initState() {
    super.initState();

    if (widget.produto == null) {
      _editarContact = new Produto();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _resquestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Novo Produto"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_editarContact.vlrUnitario != null) {
              Produto produto = Produto(
                idProduto: null,
                dscProduto: _descController.text,
                vlrUnitario: num.parse(_vlrUnitController.text),
              );

              toast("Produto Salvo com Sucesso");

              Navigator.pop(context, produto);
            } else {
              toast("Os campos descrição e valor são obrigatórios");
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
          child: Icon(Icons.save),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                focusNode: _nameFocus,
                controller: _descController,
                decoration: InputDecoration(
                  labelText: "Descrição",
                ),
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    _editarContact.dscProduto = text;
                  });
                },
              ),
              TextField(
                controller: _vlrUnitController,
                decoration: InputDecoration(
                  labelText: "Valor",
                ),
                onChanged: (text) {
                  _userEdited = true;
                  _editarContact.vlrUnitario = num.parse(text);
                },
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _resquestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("ATENÇÃO"),
              content: Text("Deseja sair sem salvar as alterações?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  void toast(String texto) {
    Fluttertoast.showToast(
        msg: texto,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
