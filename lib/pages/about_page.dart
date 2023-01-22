import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Coleta de Validade",
                style: TextStyle(color: Colors.green, fontSize: 30.0),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text('Version: 1.1.2'),
              Text('Desenvolvido por: Carlos Lima'),
              Text(
                  'Download em: https://github.com/EduardoLima03/validade/releases')
            ],
          ),
        ),
      ),
    );
  }
}
