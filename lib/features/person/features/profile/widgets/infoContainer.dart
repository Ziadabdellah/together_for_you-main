import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:together_for_you/core/utils/styles.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer({super.key, required this.icon, required this.info});
  final Icon icon;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue.withOpacity(.1),
        ),
        child: Row(
          children: [
            icon,
            Gap(20),
            Text(
              info,
              style: getBodyStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
