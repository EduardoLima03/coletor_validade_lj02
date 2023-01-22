class ProductModel {
  String? cod;
  String? ean;
  String? description;

  ProductModel({this.cod, this.ean, this.description});

  ProductModel.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    ean = json['ean'];
    description = json['descricao'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cod'] = cod;
    data['descricao'] = description;
    data['ean'] = ean;
    return data;
  }
}
