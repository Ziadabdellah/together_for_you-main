import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:together_for_you/core/utils/styles.dart';
import 'package:together_for_you/features/person/features/specials/widgets/specialcard.dart';

class Specials extends StatefulWidget {
  const Specials({super.key});

  @override
  State<Specials> createState() => _SpecialsState();
}

class _SpecialsState extends State<Specials> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 45.0),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 50,
                color: Colors.grey.withOpacity(.2),
                child: Text('Special', style: getTitleStyle()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('saved')
                      .where('userid', isEqualTo: user?.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    var services = snapshot.data!.docs;
                    // ignore: unnecessary_null_comparison
                    return services != null && services.isNotEmpty
                        ? SizedBox(
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: ((context, index) {
                                  var ser = index < services.length
                                      ? services[index].data()
                                      : null;
                                  return ser != null
                                      ? SpecialCard(
                                          type: ser['service'] ?? '',
                                          image: ser['image'] ?? '',
                                          name: ser['adminname'] ?? '',
                                          price: ser['price'] ?? '',
                                          cartype: ser['cartype'] ?? '',
                                          Rating: ser['rating'] ?? 0,
                                          sp: ser['speclization'] ?? '',
                                          phone: ser['phone'] ?? '',
                                          adminid: ser['adminid'] ?? '')
                                      : Container();
                                }),
                                separatorBuilder: (context, index) => const Gap(0),
                                itemCount: 3),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Gap(300),
                              Center(
                                child: Text('There is no Saved Providers yet!!',
                                    style: getTitleStyle(color: Colors.indigo)),
                              ),
                            ],
                          );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
