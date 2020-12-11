import 'package:app/dao/vendadao.dart';
import 'package:app/model/venda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class VendaPage extends StatefulWidget {
  @override
  _VendaPageState createState() => _VendaPageState();
}

class _VendaPageState extends State<VendaPage> {
  bool campoTexto = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Venda"),
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
                BlocProvider.of<VendaCubitDAO>(context).deleteAllVendas();
              }),
        ],
      ),

      //Container para carregar a lista de clientes
      body: _body(),
    );
  }

  Widget appBar() {
    return Expanded(
      child: TextFormField(
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: 20),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.black38),
          hintText: "Pesquisar Venda",
        ),
      ),
    );
  }

  _body() {
    return BlocBuilder<VendaCubitDAO, List<Venda>>(
        builder: (context, listaVenda) {
      if (listaVenda != null) {
        return ListView.builder(
          itemCount: listaVenda.length,
          itemBuilder: (_, index) {
            String data;
            int aux;
            dynamic aux2, aux3;

            data = listaVenda[index]
                .dthVenda
                .replaceAll('\\', '')
                .replaceAll('/', '')
                .replaceAll('Date', '')
                .replaceAll('(', '')
                .replaceAll(')', '');

            aux = int.parse(data);

            aux2 = DateTime.fromMillisecondsSinceEpoch(aux);
            aux3 = DateFormat.Hms().format(aux2) +
                " " +
                DateFormat.MMMMEEEEd().format(aux2);

            return ListTile(
              leading: CircleAvatar(
                child: Text(listaVenda[index].idVenda.toString()),
              ),
              title: Text(aux3),
              subtitle: Text(listaVenda[index].vlrUnitarioVenda.toString()),
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
