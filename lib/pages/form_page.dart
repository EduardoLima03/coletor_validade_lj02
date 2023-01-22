import 'dart:convert';

import 'package:coleta_de_validade/api/busca_desc/busca_desc.dart';
import 'package:coleta_de_validade/pages/about_page.dart';
import 'package:coleta_de_validade/widgets/text_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../api/sheets/user_sheets_api.dart';
import '../models/user_fields_model.dart';

class FormPage extends StatefulWidget {
  const FormPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  var codControl = TextEditingController();
  var eanControl = TextEditingController();
  var descControl = TextEditingController();
  final _dateContrl = TextEditingController();
  final _qualyControl = TextEditingController();

  /// barcode*/
  String _scanBarcode = 'Unknown';
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
    await mostraDesc();
  }

  /*
    atributos para dropdown
   */
  final selectedAuditor = ValueNotifier('');
  final auditor = [
    'REPOSITOR',
    'PROMOTOR',
    'BRIGADA DE VALIDADE',
    'CONTROLADORIA MEDEIROS'
  ];
  final selectedSetor = ValueNotifier('');
  final setor = [
    'CANTINHO DA OFERTAS',
    'PONTO EXTRA ENTRADA',
    'RACK DE CEREAIS',
    'EXPOSITOR DE PÃES',
    'RETAGUARDA PADARIA',
    'EXPOSITOR PADARIA DIVERSOS',
    'BALCÃO DE LATICÍNIOS',
    'BALCÃO FLV',
    'PONTO DE EXTRA DE CONGELADOS',
    'ILHAS DE CONGELADOS',
    'GELADEIRA COCA PADARIA',
    'GELADEIRA COCA GRANDE',
    'GELADEIRA COCA 01',
    'GELADEIRA COCA 02',
    'GELADEIRA REQ/MARG/IOG',
    'COOLER',
    'EXPOSITOR DE CHURRASCO',
    'EXPOSITOR DE SALGADINHOS COOLER',
    'CORREDOR DE BEBIDAS',
    'CORREDOR BISCOITOS',
    'CORREDOR MATINAIS',
    'CORREDOR AUTOMOTIVO/RAÇÃO',
    'CORREDOR DE LIMPEZA',
    'CORREDOR PERFUMARIA',
    'GÔNDULA DE CONSERVAS/CONDIMENTOS E MOLHOS',
    'CORREDOR NATURAIS',
    'CORREDOR DE MASSAS',
    'CORREDOR DE BAZAR',
    'CORREDOR DE ACHOCOLATADOS/LEITE UHT',
    'GÔNDULAS BISCOITOS ESPECIAIS',
    'PONTO EXTRA FRIOS',
    'PONTO EXTRA FUNDO LOJA',
    'CHECK STAND PDV 1',
    'CHECK STAND PDV 2',
    'CHECK STAND PDV 3',
    'CHECK STAND PDV 4',
    'CHECK STAND PDV 5',
    'CHECK STAND PDV 6',
    'CHECK STAND PDV 7',
  ];

  Future<String> getDesc() async {
    isSave = true;

    var url = Uri.parse(
      'http://192.168.18.6:8080/api/by-ean/${eanControl.text.toString()}',
    );
    var response = await http.get(url, headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
    });

    if(response.statusCode == 200){
      var myJson = json.decode(response.body);

      return myJson['description'];
    }else{
      return "Erro";
    }


    /*// cria a lista com a respostas separada por "<"
    var list = response.body.split('<');
    //retorn com a descricao
    var desc;
    for (var t in list) {
      if (t.contains('product_description')) {
        var separacao = t.split('>');
        desc = separacao[1];
        print("desc.toString()");
        print(desc.toString());
        break;
      }
      return desc.toString();
    }
    return "Erro";*/

  }

  mostraDesc() async {
    if (_scanBarcode.isNotEmpty) {
      eanControl.text = _scanBarcode;
      var text = await getDesc();
      setState(() {
        descControl.text = text.toString();
        isSave = false;
      });
    }
  }

  /*
  * informar qua esta enviado os dados
  * */
  bool isSave = false;

  @override
  initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    codControl.dispose();
    eanControl.dispose();
    descControl.dispose();
    _dateContrl.dispose();
    _qualyControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutPage()));
              },
              icon: const Icon(Icons.help))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFieldCustom(
                  label: "Code",
                  controler: codControl,
                  inputType: TextInputType.number,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 7,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: "EAN",
                        ),
                        controller: eanControl,
                        validator: (value) {
                          if (value!.isEmpty) return 'Campo obrigatorio';
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        onChanged: (newValue){
                          if(newValue.length > 6){
                            mostraDesc();
                          }
                        },

                      ),
                    ),
                    Flexible(
                        flex: 1,
                        child: IconButton(
                          icon: const Icon(Icons.qr_code_scanner),
                          onPressed: () => scanBarcodeNormal(),
                        )),
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Descrição"),
                  controller: descControl,
                  validator: (value) {
                    if (value == null || value.isEmpty || value == "Erro")
                      return 'Campo obrigatorio';
                    return null;
                  },
                  onChanged: (value) {
                    if (descControl.text.isEmpty) {
                      mostraDesc();
                    }
                  },
                ),
                TextFormField(
                  controller: _qualyControl,
                  decoration: const InputDecoration(
                      hintText: "Quantidade", labelText: "Quantidade"),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Campo obrigatorio';
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: _dateContrl,
                  decoration: const InputDecoration(labelText: "Validade"),
                  onTap: () async {
                    var date1 = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2030));
                    _dateContrl.text = date1.toString();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Campo obrigatorio';
                    return null;
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: selectedAuditor,
                  builder: (BuildContext context, String value, _) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonFormField<String>(
                        hint: const Text('AUDITOR'),
                        decoration: const InputDecoration(
                          label: Text('AUDITOR'),
                        ),
                        value: (value.isEmpty) ? null : value,
                        onChanged: (escolha) =>
                            selectedAuditor.value = escolha.toString(),
                        items: auditor
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                      ),
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: selectedSetor,
                  builder: (BuildContext context, String value, _) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonFormField<String>(
                        hint: const Text(
                          'SELECIONE O SETOR AUDITADO',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        decoration: const InputDecoration(
                          label: Text(
                            'SELECIONE O SETOR AUDITADO',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                        value: (value.isEmpty) ? null : value,
                        onChanged: (escolha) =>
                            selectedSetor.value = escolha.toString(),
                        items: setor
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: const TextStyle(fontSize: 12.0),
                                  ),
                                ))
                            .toList(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: isSave
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              if (selectedAuditor.value.isEmpty ||
                                  selectedSetor.value.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      'Campo Auditor e Setor obrigatorio!'),
                                  backgroundColor: Colors.red,
                                ));
                              } else {
                                final user = {
                                  UserFields.carimbo:
                                      DateFormat("dd/MM/yyyy HH:mm:ss")
                                          .format(DateTime.now()),
                                  UserFields.auditor: selectedAuditor.value,
                                  UserFields.setor: selectedSetor.value,
                                  UserFields.descricao: descControl.text,
                                  UserFields.ean: eanControl.text,
                                  UserFields.quantidade: _qualyControl.text,
                                  UserFields.validade: DateFormat("dd/MM/yyy")
                                      .format(DateTime.parse(
                                          _dateContrl.text.toString())),
                                };
                                await UserSheetsApi.insert([user]);
                                clearForm();
                              }
                            }
                          },
                    child: Visibility(
                      visible: isSave,
                      replacement: const Text("Enviar"),
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void clearForm() {
    setState(() {
      codControl.text = "";
      eanControl.text = "";
      descControl.text = "";
      _dateContrl.text = "";
      _qualyControl.text = '';
    });
  }
}
