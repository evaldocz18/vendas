import 'package:app/dao/clientedao.dart';
import 'package:app/model/cliente.dart';
import 'package:app/pages/cliente/cliente_edit_page.dart';
import 'package:app/pages/cliente/clientes_cad_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientePage extends StatefulWidget {
  @override
  _ClientePageState createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  bool campoTexto = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cliente"),
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
                BlocProvider.of<ClienteCubitDAO>(context).deleteAllClientes();
              }),
        ],
      ),

      //Container para carregar a lista de clientes
      body: BlocBuilder<ClienteCubitDAO, List<Cliente>>(
        builder: (context, state) {
          if (state != null) {
            if (state.length > 0) {
              return _listaCliente(state);
            } else {
              return Center(
                child: Text('Nenhum cliente cadastrado.'),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroClientePage()),
          );
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
          hintText: "Pesquisar Cliente",
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      child: BlocBuilder<ClienteCubitDAO, List<Cliente>>(
        builder: (context, state) {
          if (state != null) {
            if (state.length > 0) {
              return _listaCliente(state);
            } else {
              return Center(
                child: Text('Nenhum cliente cadastrado.'),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  _listaCliente(List<Cliente> listaCliente) {
    return ListView.builder(
      itemCount: listaCliente.length,
      itemBuilder: (_, index) {
        return ListTile(
          title: Text(listaCliente[index].nmCliente),
          subtitle: Text("Cidade: " + listaCliente[index].cidade),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditClientePage(
                                cliente: listaCliente[index],
                              )),
                    );
                  }),
              /*IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: null,
              ),*/
            ],
          ),
        );
      },
    );
  }
}
