class Produto {
  int idProduto;
  String dscProduto;
  num vlrUnitario;

  Produto({this.idProduto, this.dscProduto, this.vlrUnitario});

  Produto.fromJson(Map<String, dynamic> json) {
    idProduto = json['idProduto'];
    dscProduto = json['dscProduto'];
    vlrUnitario = json['vlrUnitario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idProduto'] = this.idProduto;
    data['dscProduto'] = this.dscProduto;
    data['vlrUnitario'] = this.vlrUnitario;
    return data;
  }
}
