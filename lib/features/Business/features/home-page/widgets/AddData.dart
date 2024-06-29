import 'package:flutter/material.dart';
import 'package:together_for_you/core/functions/route.dart';
import 'package:together_for_you/core/utils/styles.dart';
import 'package:together_for_you/features/Business/features/home-page/EnterData.dart';

class AddData extends StatelessWidget {
  const AddData({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Text(
            'Enter Your Required Data :',
            style: getTitleStyle(fontWeight: FontWeight.normal),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                push(context, EnterData(Type: type));
              },
              icon: const Icon(Icons.arrow_forward_ios_outlined))
        ],
      ),
    );
  }
}
