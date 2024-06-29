import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      this.onTap,
      this.width = 100,
      this.style,
      required this.bgcolor,
      this.hieght = 40});
  final String text;
  final Function()? onTap;
  final double width;
  final TextStyle? style;
  final Color bgcolor;
  final double hieght;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: hieght,
        width: width,
        decoration: BoxDecoration(
            color: bgcolor, borderRadius: BorderRadius.circular(15)),
        child: Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}
