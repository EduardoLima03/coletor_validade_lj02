import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightGreen,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/icon.png'),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Coleta de Validade',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
