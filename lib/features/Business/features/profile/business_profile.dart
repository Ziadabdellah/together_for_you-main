import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:together_for_you/core/functions/route.dart';
import 'package:together_for_you/core/utils/styles.dart';
import 'package:together_for_you/features/Business/features/profile/business_edit_profile.dart';
import 'package:together_for_you/features/person/features/profile/widgets/infoContainer.dart';


class BusinessProfile extends StatefulWidget {
  const BusinessProfile({super.key});

  @override
  State<BusinessProfile> createState() => _BusinessProfileState();
}

class _BusinessProfileState extends State<BusinessProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  String? UserID;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Busniss')
                .where('email', isEqualTo: user?.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var userData = snapshot.data!.docs;
              print(userData);

              // ignore: unnecessary_null_comparison
              return userData[0] != null
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 45.0),
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 50,
                            color: Colors.grey.withOpacity(.2),
                            child: Row(
                              children: [
                                const Spacer(),
                                Text('Profile', style: getTitleStyle()),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      push(context, const BusinessEditProfile());
                                    },
                                    icon: const Icon(Icons.edit_outlined)),
                              ],
                            ),
                          ),
                        ),
                        const Gap(20),
                        CircleAvatar(
                            radius: 90,
                            backgroundColor: Colors.blue.withOpacity(.1),
                            backgroundImage: userData[0]['image'] == null
                                ? const AssetImage('assets/icons/profile(1).png')
                                    as ImageProvider<Object>
                                : NetworkImage(userData[0]['image'] as String)
                                    as ImageProvider<Object>),
                        const Gap(30),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Column(
                            children: [
                              InfoContainer(
                                  icon: const Icon(Icons.person),
                                  info: userData[0]['name']),
                              InfoContainer(
                                  icon: const Icon(Icons.phone),
                                  info: userData[0]['phone']),
                              InfoContainer(
                                  icon: const Icon(Icons.email),
                                  info: userData[0]['email']),
                              if (userData[0]['service'] == 'Nurse')
                                InfoContainer(
                                    icon: const Icon(Icons.wheelchair_pickup),
                                    info: userData[0]['speclization'] ??
                                        'not Specified yet'),
                              InfoContainer(
                                  icon: const Icon(Icons.location_pin),
                                  info: userData[0]['address']),
                            ],
                          ),
                        )
                      ],
                    )
                  : Container();
            }),
      ),
    );
  }
}
