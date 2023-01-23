import 'package:http/http.dart' as http;
import 'dart:convert';

class BuscaDesc {
  static Future<Map> getDesc(ean) async {
    var url = Uri.parse(
      'https://apirest-validade-medeiros.herokuapp.com/product/${ean.text.toString()}',
    );
    var response = await http.get(url, headers: <String, String>{
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json'
    });

    var text = <dynamic, dynamic>{};

    if (response.statusCode == 200) {
      var mJson = jsonDecode(response.body);
      text['descricao'] = mJson['descricao'];
      text['cod'] = mJson['cod'];
      return text;
    } else {
      var url = Uri.parse(
        'https://cosmos.bluesoft.com.br/produtos/${ean.toString()}',
      );
      var response = await http.get(url);
      // cria a lista com a respostas separada por "<"
      var list = response.body.split('<');
      //retorn com a descricao
      var desc;
      for (var t in list) {
        if (t.contains('product_description')) {
          var separacao = t.split('>');
          desc = separacao[1];
          break;
        }
      }
      text['descricao'] = desc.toString();
      return text;
    }
  }
}
