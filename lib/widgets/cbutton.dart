import 'package:flutter/material.dart';
import 'package:flutter_assignment/constants/colors.dart';
import 'package:get/get.dart';

class CustColorButton extends StatelessWidget {
  String? title;
  Function()? onPressed;
  Color? color;

  CustColorButton({Key? key, this.title, this.onPressed, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(color ?? colorPrimary),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title ?? '',
            style: const TextStyle(color: colorTeal),
          ),
        ),
      ),
    );
  }
}
