import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final Widget child;
  const InputWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20), child: child));
  }
}
