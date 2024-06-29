import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:together_for_you/core/Widgets/custom_button.dart';
import 'package:together_for_you/core/utils/styles.dart';

showSentAlertDialog(BuildContext context,
    {String? ok,
    String? no,
    required String title,
    void Function()? onTap,
    required String alert,
    required String Subtiltle, required String subtitle}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.grey,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (ok != null)
                      Container(
                        width: 280,
                        height: 400,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: Column(
                          children: [
                            const Gap(50),
                            const Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 55,
                                  backgroundColor: Colors.green,
                                ),
                                CircleAvatar(
                                  radius: 45,
                                  backgroundColor: Colors.green,
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.done_outline_rounded,
                                      color: Colors.green,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const Gap(30),
                            Text(
                              textAlign: TextAlign.center,
                              alert,
                              style: getTitleStyle(),
                            ),
                            const Gap(15),
                            Text(
                              Subtiltle,
                              style: getBodyStyle(color: Colors.grey),
                            ),
                            const Gap(30),
                            CustomButton(
                                onTap: onTap,
                                text: ok,
                                bgcolor: Colors.blue.withOpacity(.6),
                                style: getBodyStyle(color: Colors.white),
                                width: 200)
                          ],
                        ),
                      ),
                    if (no != null)
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.green),
                          child: Text(
                            no,
                            style: getBodyStyle(color: Colors.black),
                          ),
                        ),
                      ),
                  ],
                )
              ],
            ),
          )
        ],
      );
    },
  );
}
