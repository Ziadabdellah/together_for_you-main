import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:together_for_you/core/Widgets/rating.dart';
import 'package:together_for_you/core/utils/styles.dart';

class ServiceCard extends StatefulWidget {
  const ServiceCard(
      {super.key,
      required this.type,
      required this.image,
      required this.name,
      required this.price,
      required this.cartype,
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

  final int Rating;

  final String sp;
  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
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

  Future<void> isJobSaved(String admin) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('saved')
        .where('userid', isEqualTo: user?.uid)
        .where('adminid', isEqualTo: admin)
        .get();
    if (snapshot.docs.isNotEmpty) {
      setState(() {
        issaved = true;
      });
    }
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
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  Future<void> save() async {
    try {
      FirebaseFirestore.instance.collection('saved').add({
        'userid': user?.uid,
        'adminid': widget.adminid,
        'image': widget.image,
        'adminname': widget.name,
        'speclization': widget.sp,
        'cartype': widget.cartype,
        'adminphone': widget.phone,
        'service': widget.type,
        'rating': widget.Rating
      });
    } catch (e) {
      print(e);
    }

    // Optionally, you can clear the text field after adding the skill
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
    isJobSaved(widget.adminid);
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
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black.withOpacity(.3))),
        child: Row(children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: widget.image == ''
                    ? Image.asset(
                        'assets/icons/profile(1).png',
                        width: 50,
                        fit: BoxFit.fill,
                      )
                    : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.image,
                            fit: BoxFit.fill,)),
                    )),
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
                  if (widget.type == 'driver')
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
                          child: Text('Car Type:  ${widget.cartype}',style: getSmallStyle()),
                        ),
                      ],
                    ),
                  if (widget.type == 'cleaner')
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
                          child: Text('price:  ${widget.price}',style: getSmallStyle()),
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
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      if (issaved) {
                        deleteDocument(admin: widget.adminid);
                      } else {
                        save();
                      }
                      toggleSaved();
                    },
                    icon: Icon(
                      issaved
                          ? Icons.favorite
                          : Icons.favorite_outline_outlined,
                      color: Colors.red,
                    )),
              ],
            ),
          ),
        ]));
  }
}
