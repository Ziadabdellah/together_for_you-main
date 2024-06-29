import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:together_for_you/core/Widgets/custom_button.dart';
import 'package:together_for_you/core/Widgets/rating.dart';
import 'package:together_for_you/core/utils/styles.dart';

class SpecialCard extends StatefulWidget {
  const SpecialCard(
      {super.key,
      required this.type,
      required this.image,
      required this.name,
      required this.price,
      required this.cartype,
      // ignore: non_constant_identifier_names
      required this.Rating,
      required this.sp,
      required this.phone,
      required this.adminid});
  final String type;
  final String image;
  final String name;
  final String price;
  final String cartype;
  final String phone;
  final String adminid;

  // ignore: non_constant_identifier_names
  final int Rating;

  final String sp;
  @override
  State<SpecialCard> createState() => _SpecialCardState();
}

class _SpecialCardState extends State<SpecialCard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  bool issaved = false;
  void toggleSaved() {
    setState(() {
      issaved = !issaved;
    });
  }

  Future<void> deleteDocument({required String admin}) async {
    try {
      // Perform a query to find the document based on fields
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('saved')
          .where('userid', isEqualTo: user?.uid)
          .where('adminid', isEqualTo: admin)
          .get();

      // Delete the found document(s)
      for (var doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error deleting document: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 30),
        height: 150,
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
        child: Row(children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
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
                        width: 154,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue.withOpacity(.1),
                        ),
                        child: Text(widget.name, style: getSmallStyle()),
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
                          width: 154,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue.withOpacity(.1),
                          ),
                          child:
                              Text('sp: ${widget.sp}', style: getSmallStyle()),
                        ),
                      ],
                    ),
                  if (widget.type == 'Driver')
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 40,
                          width: 154,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue.withOpacity(.1),
                          ),
                          child: Text('Car Type:  ${widget.cartype}',
                              style: getSmallStyle()),
                        ),
                      ],
                    ),
                  if (widget.type == 'Cleaner')
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 40,
                          width: 154,
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
          Expanded(
            flex: 1,
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: Colors.white,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Gap(20),
                                      Text(
                                        textAlign: TextAlign.center,
                                        'Are you sure you want to remove this service provider??',
                                        style: getBodyStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                      const Gap(30),
                                      Row(
                                        children: [
                                          CustomButton(
                                              hieght: 30,
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              text: 'cancel',
                                              style: getSmallStyle(fontSize: 5),
                                              bgcolor: Colors.green),
                                          const Gap(20),
                                          CustomButton(
                                              hieght: 30,
                                              onTap: () {
                                                Navigator.pop(context);
                                                deleteDocument(
                                                    admin: widget.adminid);
                                              },
                                              text: 'Remove',
                                              style: getSmallStyle(fontSize: 3),
                                              bgcolor: Colors.red)
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )),
              ],
            ),
          ),
        ]));
  }
}
