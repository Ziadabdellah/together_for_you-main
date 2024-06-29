import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
   CustomText({super.key, required this.text});

   String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.blue[900],
        fontSize:18,
      ),
    );
  }
}
