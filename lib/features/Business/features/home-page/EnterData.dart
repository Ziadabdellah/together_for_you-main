import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import 'package:together_for_you/core/Widgets/custom_button.dart';
import 'package:together_for_you/core/Widgets/dialogs.dart';
import 'package:together_for_you/core/Widgets/respondAlert.dart';
import 'package:together_for_you/core/utils/styles.dart';
import 'package:together_for_you/features/Business/features/home-page/widgets/header.dart';
//import 'package:together_for_you/features/Business/home/home-page/widgets/header.dart';

class EnterData extends StatefulWidget {
  const EnterData({super.key, required this.Type});
  final String Type;

  @override
  State<EnterData> createState() => _EnterDataState();
}

class _EnterDataState extends State<EnterData> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
  }

  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey4 = GlobalKey<FormState>();

  final TextEditingController _nurseSp = TextEditingController();
  final TextEditingController _nurcePrice = TextEditingController();
  final TextEditingController _carTypr = TextEditingController();

  final TextEditingController _carNumber_ = TextEditingController();
  final TextEditingController _cleaningPrice = TextEditingController();
  final TextEditingController _cleaningphone = TextEditingController();
  final TextEditingController _deliveryPhone = TextEditingController();

  void updateuser({
    required int type,
    required String nursesp,
    required String nurseprice,
    required String cartype,
    required String carNumber,
    required String cleaningprice,
    required String cleaningphone,
    required String delivryphone,
  }) {
    try {
      if (type == 1) {
        FirebaseFirestore.instance.collection('Busniss').doc(user?.uid).set({
          'speclization': nursesp,
          'price': nurseprice,
        }, SetOptions(merge: true));
      } else if (type == 2) {
        FirebaseFirestore.instance.collection('Busniss').doc(user?.uid).set(
            {'carType': cartype, 'carNumber': carNumber},
            SetOptions(merge: true));
      } else if (type == 3) {
        FirebaseFirestore.instance
            .collection('Busniss')
            .doc(user?.uid)
            .set({'phone': delivryphone}, SetOptions(merge: true));
      } else {
        FirebaseFirestore.instance.collection('Busniss').doc(user?.uid).set(
            {'phone': cleaningphone, 'price': cleaningprice},
            SetOptions(merge: true));
      }

      showSentAlertDialog(context,
          title: 'done',
          ok: 'ok',
          alert: 'Updated Successfuly',
          subtitle: '', onTap: () {
        Navigator.pop(context);
      }, Subtiltle: '', );
    } catch (e) {
      showErrorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header(type: widget.Type),
          Gap(20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  'Enter Your Required Data :',
                  style: getTitleStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          if (widget.Type == 'Nurse')
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey1,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _nurseSp,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          label: const Text('Speclization'),
                          // labelStyle: getBodyStyle(),
                          hintText: 'Enter Your Speclization  ',
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Speclization';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _nurcePrice,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          label: const Text('Service Price'),
                          // labelStyle: getBodyStyle(),
                          hintText: 'Enter Your price  ',
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your price';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Gap(20),
                    CustomButton(
                        onTap: () {
                          if (_formKey1.currentState!.validate()) {
                            updateuser(
                                type: 1,
                                nursesp: _nurseSp.text,
                                nurseprice: _nurcePrice.text,
                                cartype: _carTypr.text,
                                carNumber: _carNumber_.text,
                                cleaningprice: _cleaningPrice.text,
                                cleaningphone: _cleaningphone.text,
                                delivryphone: _deliveryPhone.text);
                          }
                          ;
                        },
                        text: 'Set',
                        bgcolor: Colors.blue.withOpacity(.5))
                  ],
                ),
              ),
            ),
          if (widget.Type == 'Driver')
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _carTypr,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          label: const Text('Car Type'),
                          // labelStyle: getBodyStyle(),
                          hintText: 'Enter Your type  ',
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your type';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _carNumber_,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          label: const Text('Car Number'),
                          // labelStyle: getBodyStyle(),
                          hintText: 'Enter Your car number  ',
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your car number';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Gap(20),
                    CustomButton(
                        onTap: () {
                          if (_formKey2.currentState!.validate()) {
                            updateuser(
                                type: 2,
                                nursesp: _nurseSp.text,
                                nurseprice: _nurcePrice.text,
                                cartype: _carTypr.text,
                                carNumber: _carNumber_.text,
                                cleaningprice: _cleaningPrice.text,
                                cleaningphone: _cleaningphone.text,
                                delivryphone: _deliveryPhone.text);
                            ;
                          }
                          ;
                        },
                        text: 'Set',
                        bgcolor: Colors.blue.withOpacity(.5))
                  ],
                ),
              ),
            ),
          if (widget.Type == 'Delivery')
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey3,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _deliveryPhone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          label: const Text('Phone Number'),
                          // labelStyle: getBodyStyle(),
                          hintText: 'Enter Your Phone number  ',
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Phone number';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Gap(20),
                    CustomButton(
                        onTap: () {
                          if (_formKey3.currentState!.validate()) {
                            updateuser(
                                type: 3,
                                nursesp: _nurseSp.text,
                                nurseprice: _nurcePrice.text,
                                cartype: _carTypr.text,
                                carNumber: _carNumber_.text,
                                cleaningprice: _cleaningPrice.text,
                                cleaningphone: _cleaningphone.text,
                                delivryphone: _deliveryPhone.text);
                            ;
                          }
                          ;
                        },
                        text: 'Set',
                        bgcolor: Colors.blue.withOpacity(.5))
                  ],
                ),
              ),
            ),
          if (widget.Type == 'Cleaner')
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey4,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _cleaningphone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          label: const Text('Phone Number'),
                          // labelStyle: getBodyStyle(),
                          hintText: 'Enter Your phone number  ',
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _cleaningPrice,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          label: const Text('Service Price'),
                          // labelStyle: getBodyStyle(),
                          hintText: 'Enter Your service price ',
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your service price';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Gap(20),
                    CustomButton(
                        onTap: () {
                          if (_formKey1.currentState!.validate()) {
                            updateuser(
                                type: 4,
                                nursesp: _nurseSp.text,
                                nurseprice: _nurcePrice.text,
                                cartype: _carTypr.text,
                                carNumber: _carNumber_.text,
                                cleaningprice: _cleaningPrice.text,
                                cleaningphone: _cleaningphone.text,
                                delivryphone: _deliveryPhone.text);
                            ;
                          }
                          ;
                        },
                        text: 'Set',
                        bgcolor: Colors.blue.withOpacity(.5))
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
