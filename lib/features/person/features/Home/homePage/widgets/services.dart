import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:together_for_you/core/utils/styles.dart';

import 'package:together_for_you/core/functions/route.dart';

import 'package:together_for_you/features/person/features/Home/homePage/widgets/chosenService.dart';
import 'package:together_for_you/features/person/features/Home/homePage/widgets/service.dart';

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
      child: SizedBox(
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(children: [
                Text(
                  'List Of Services :',
                  style: getTitleStyle(fontWeight: FontWeight.normal),
                )
              ]),
            ),
            Expanded(
                flex: 8,
                child: GridView(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200, // Adjust as needed
                      childAspectRatio: 1.5, //

                      crossAxisSpacing: 10,
                      mainAxisExtent: 180,
                      mainAxisSpacing: 20),
                  children: [
                    GestureDetector(
                      onTap: () {
                        push(context, const ChosenService(type: 'Nurse'));
                      },
                      child: const service(
                        name: 'Nurse',
                        icon: 'assets/icons/doctor.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        push(context, const ChosenService(type: 'Delivery'));
                      },
                      child: const service(
                        name: 'Delivery',
                        icon: 'assets/icons/delivery.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        push(context, const ChosenService(type: 'Driver'));
                      },
                      child: const service(
                        name: 'Driver',
                        icon: 'assets/icons/driver.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        push(context, const ChosenService(type: 'Cleaner'));
                      },
                      child: const service(
                        name: 'House Cleaner',
                        icon: 'assets/icons/woman.png',
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
