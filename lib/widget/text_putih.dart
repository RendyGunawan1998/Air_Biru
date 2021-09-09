import 'package:flutter/material.dart';

class TextPutih extends StatelessWidget {
  final String? text;
  const TextPutih({Key? key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '-',
      style:
          TextStyle(color: Colors.white, decoration: TextDecoration.underline),
    );
  }
}
