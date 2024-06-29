import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:together_for_you/core/Widgets/rating.dart';
import 'package:together_for_you/core/utils/styles.dart';

class SerCard extends StatefulWidget {
  const SerCard({
    super.key,
    required this.type,
    required this.image,
    required this.name,
    required this.price,
    required this.cartype,
    required this.sp,
    required this.Rating,
  });
  final String type;
  final String image;
  final String name;
  final String price;
  final String cartype;
  // ignore: non_constant_identifier_names
  final int Rating;

  final String sp;

  @override
  State<SerCard> createState() => _SerCardState();
}

class _SerCardState extends State<SerCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      height: 150,
      padding: const EdgeInsets.only(bottom: 10),
      width: 400,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.3), // shadow color
              spreadRadius: 5, // spread radius
              blurRadius: 3, // blur radius
              offset: const Offset(0, 5),
              // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.black.withOpacity(.3))),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: widget.image == ''
                      ? Image.asset(
                          'assets/icons/profile(1).png',
                          width: 50,
                          fit: BoxFit.fill,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            widget.image,
                            fit: BoxFit.fill,
                          ))),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Gap(20),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        height: 40,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue.withOpacity(.1),
                        ),
                        child: Text(widget.name),
                      ),
                    ],
                  ),
                  const Gap(10),
                  if (widget.type == 'Nurse')
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 40,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue.withOpacity(.1),
                          ),
                          child:
                              Text('sp: ${widget.sp}', style: getSmallStyle()),
                        ),
                      ],
                    ),
                  if (widget.type == 'driver')
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 40,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue.withOpacity(.1),
                          ),
                          child: Text('sp:  ${widget.cartype}',
                              style: getSmallStyle()),
                        ),
                      ],
                    ),
                  if (widget.type == 'cleaner')
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 40,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue.withOpacity(.1),
                          ),
                          child: Text('price:  ${widget.price}',
                              style: getSmallStyle()),
                        ),
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Rating(
                        rating: widget.Rating,
                        filledColor: Colors.blue,
                        emptyColor: Colors.blue),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
