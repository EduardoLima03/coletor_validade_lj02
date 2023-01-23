import 'package:coleta_de_validade_lj01/pages/form_page.dart';
import 'package:coleta_de_validade_lj01/pages/splash_page.dart';
import 'package:flutter/material.dart';

import 'api/sheets/user_sheets_api.dart';

void main() async {
  runApp(const SplashPage());
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetsApi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coletor de Validade',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const FormPage(),
    );
  }
}
