import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:together_for_you/core/functions/route.dart';
import 'package:together_for_you/core/utils/styles.dart';
import 'package:together_for_you/features/person/features/profile/editProfile.dart';
import 'package:together_for_you/features/person/features/profile/widgets/infoContainer.dart';

class PersonProfile extends StatefulWidget {
  const PersonProfile({Key? key}) : super(key: key);

  @override
  State<PersonProfile> createState() => _PersonProfileState();
}

class _PersonProfileState extends State<PersonProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  String? userID;

  Future<void> _getUser() async {
    user = _auth.currentUser;
    setState(() {
      userID = user?.uid;
    });
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
              .collection('Person')
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

            if (userData.isNotEmpty) {
              return Column(
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
                              push(context, const EditProfilePerson());
                            },
                            icon: const Icon(Icons.edit_outlined),
                          ),
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
                            as ImageProvider<Object>,
                  ),
                  const Gap(30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        InfoContainer(
                          icon: const Icon(Icons.person),
                          info: userData[0]['name'],
                        ),
                        InfoContainer(
                          icon: const Icon(Icons.phone),
                          info: userData[0]['phone'],
                        ),
                        InfoContainer(
                          icon: const Icon(Icons.email),
                          info: userData[0]['email'],
                        ),
                        InfoContainer(
                          icon: const Icon(Icons.location_pin),
                          info: userData[0]['address'],
                        ),
                        InfoContainer(
                          icon: const Icon(Icons.wheelchair_pickup),
                          info: userData[0]['Disabilitytype'],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
