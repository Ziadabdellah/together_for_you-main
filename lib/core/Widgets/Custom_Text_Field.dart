
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({super.key, this.suffixIcon, required this.labelText});
 IconData? suffixIcon;
  String labelText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10,),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20)
        ),
        height: 50,
        child: TextField(
          decoration: InputDecoration(
            labelText: labelText,
            suffixIcon: Icon(suffixIcon),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(25),

            ),
          ),
        ),
      ),
    );
  }
}



// ignore: must_be_immutable
class CustomTextField2 extends StatelessWidget {
  CustomTextField2({super.key, this.suffixIcon, required this.labelText,required this.prefixIcon});
 IconData? suffixIcon;
  String labelText;
  IconData?prefixIcon;
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10,),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20)
        ),
        height: 50,
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon),
            labelText: labelText,
            suffixIcon: Icon(suffixIcon),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(25),

            ),
          ),
        ),
      ),
    );
  }
}
