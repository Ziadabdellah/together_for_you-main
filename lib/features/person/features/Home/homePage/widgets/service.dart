import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class service extends StatelessWidget {
  const service({super.key, required this.name, required this.icon});
  final String name;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            width: 250,
            height: 130,
            // padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(.2),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3), // shadow color
                  spreadRadius: 2, // spread radius
                  blurRadius: 5, // blur radius
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Image.asset(
                  icon,
                  width: 120,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              name,
              style: TextStyle(
                fontFamily: GoogleFonts.exo().fontFamily,
                fontSize: 20,
                shadows: [
                  Shadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    offset: const Offset(2, 2), // Shadow position
                    blurRadius: 3, // Shadow blur radius
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}










