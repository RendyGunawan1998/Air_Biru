import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitButtonWidget extends StatelessWidget {
  final double? width;
  final Color? color;
  final VoidCallback? function;
  final String? text;
  final Color? textColor;
  const SubmitButtonWidget(
      {Key? key,
      this.width,
      this.color,
      this.function,
      this.text,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? Get.width * 0.85,
      decoration: BoxDecoration(
          color: color ?? Colors.blueAccent[100],
          borderRadius: BorderRadius.circular(30)),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text ?? '-',
          style: TextStyle(color: textColor ?? Colors.white),
        ),
      ),
    );
  }
}
