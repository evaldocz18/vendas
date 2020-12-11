import 'package:app/dao/clientedao.dart';
import 'package:app/model/cliente.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CadastroClientePage extends StatefulWidget {
  final Cliente cliente;

  CadastroClientePage({this.cliente});

  @override
  _CadastroClientePageState createState() => _CadastroClientePageState();
}

class _CadastroClientePageState extends State<CadastroClientePage> {
  final _nameController = TextEditingController();
  final _cidadeController = TextEditingController();

  final _nameFocus = FocusNode();

  bool _userEdited = false;
  Cliente _editarContact;

  @override
  void initState() {
    super.initState();

    if (widget.cliente == null) {
      _editarContact = new Cliente();
    } else {
      _nameController.text = _editarContact.nmCliente;
      _cidadeController.text = _editarContact.cidade;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _resquestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Novo Cliente"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_editarContact.cidade != null) {
              Cliente cliente = Cliente(
                  idCliente: null,
                  nmCliente: _nameController.text,
                  cidade: _cidadeController.text);
              // await ClienteDAO.insertCliente(cliente);

              toast("Cliente Salvo com Sucesso");
              BlocProvider.of<ClienteCubitDAO>(context).insertCliente(cliente);
              Navigator.pop(context);
            } else {
              toast("Os campos nome e cidade são obrigatórios");
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
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Nome",
                ),
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    _editarContact.nmCliente = text;
                  });
                },
              ),
              TextField(
                controller: _cidadeController,
                decoration: InputDecoration(
                  labelText: "Cidade",
                ),
                onChanged: (text) {
                  _userEdited = true;
                  _editarContact.cidade = text;
                },
                keyboardType: TextInputType.text,
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
