class Venda {
  int idVenda;
  String dthVenda;
  int idCliente;
  int idProduto;
  int qtdVenda;
  num vlrUnitarioVenda;

  Venda(
      {this.idVenda,
      this.dthVenda,
      this.idCliente,
      this.idProduto,
      this.qtdVenda,
      this.vlrUnitarioVenda});

  Venda.fromJson(Map<String, dynamic> json) {
    idVenda = json['idVenda'];
    dthVenda = json['dthVenda'];
    idCliente = json['idCliente'];
    idProduto = json['idProduto'];
    qtdVenda = json['qtdVenda'];
    vlrUnitarioVenda = json['vlrUnitarioVenda'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idVenda'] = this.idVenda;
    data['dthVenda'] = this.dthVenda;
    data['idCliente'] = this.idCliente;
    data['idProduto'] = this.idProduto;
    data['qtdVenda'] = this.qtdVenda;
    data['vlrUnitarioVenda'] = this.vlrUnitarioVenda;
    return data;
  }
}
