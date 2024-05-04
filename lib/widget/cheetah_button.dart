import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const CommonButton(this.text, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black)),
        child: Text(text),
      ),
    );
  }
}
