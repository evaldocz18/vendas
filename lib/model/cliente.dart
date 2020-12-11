class Cliente {
  int idCliente;
  String nmCliente;
  String cidade;

  Cliente({this.idCliente, this.nmCliente, this.cidade});

  Cliente.fromJson(Map<String, dynamic> json) {
    idCliente = json['idCliente'];
    nmCliente = json['nmCliente'];
    cidade = json['Cidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idCliente'] = this.idCliente;
    data['nmCliente'] = this.nmCliente;
    data['Cidade'] = this.cidade;
    return data;
  }
}
