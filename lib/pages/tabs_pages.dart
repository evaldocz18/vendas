import 'package:app/pages/produto/produto_pages.dart';
import 'package:app/pages/vendas/venda_pages.dart';
import 'package:flutter/material.dart';

import 'cliente/clientes_pages.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectdScreenIndex = 0;

  final List<Widget> _screens = [
    ClientePage(),
    ProdutoPage(),
    VendaPage(),
  ];

  _selectScreen(int index) {
    setState(() {
      _selectdScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectdScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.red,
        currentIndex: _selectdScreenIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.people_alt),
            // ignore: deprecated_member_use
            title: Text("Clientes"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.add_shopping_cart),
            // ignore: deprecated_member_use
            title: Text("Produtos"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.bar_chart),
            // ignore: deprecated_member_use
            title: Text("Vendas"),
          ),
        ],
      ),
    );
  }
}
