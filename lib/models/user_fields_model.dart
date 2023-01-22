class UserFields {
  static final String carimbo = 'Carimbo de data/hora';
  static final String auditor = 'AUDITOR';
  static final String setor = 'SELECIONE O SETOR AUDITADO';
  static final String descricao = 'DESCRIÇÃO DO PRODUTO';
  static final String ean = 'CÓDIGO DO PRODUTO';
  static final String quantidade = 'QUANTIDADE';
  static final String validade = 'VALIDADE';

  static List<String> getFields() =>
      [carimbo, auditor, setor, descricao, ean, quantidade, validade];
}

class User {
  final String carimbo;
  final String auditor;
  final String setor;
  final String ean;
  final String descricao;
  final String quantidade;
  final String validade;

  const User(
      {required this.descricao,
        required this.quantidade,
        required this.validade,
        required this.carimbo,
        required this.ean,
        required this.auditor,
        required this.setor});

  Map<String, String> toJson() => {
    UserFields.carimbo: carimbo,
    UserFields.descricao: descricao,
    UserFields.auditor: auditor,
    UserFields.setor: setor,
    UserFields.ean: ean,
    UserFields.quantidade: quantidade,
    UserFields.validade: validade,
  };
}
