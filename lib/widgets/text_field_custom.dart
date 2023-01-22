import 'package:flutter/material.dart';

class TextFieldCustom extends StatefulWidget {
  final String label;
  final TextEditingController controler;
  final TextInputType inputType;

  const TextFieldCustom(
      {Key? key,
      required this.label,
      required this.controler,
      this.inputType = TextInputType.none})
      : super(key: key);

  @override
  State<TextFieldCustom> createState() => _TextFieldCustom();
}

class _TextFieldCustom extends State<TextFieldCustom> {
  @override
  void dispose() {
    widget.controler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: widget.label.toString()),
      controller: widget.controler,
      keyboardType: widget.inputType,
      validator: (value) {
        if (value!.isEmpty) return 'Campo obrigatorio!';
        return null;
      },
    );
  }
}
