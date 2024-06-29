import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:together_for_you/core/Widgets/custom_button.dart';
import 'package:together_for_you/core/Widgets/dialogs.dart';
import 'package:together_for_you/core/Widgets/rating.dart';
import 'package:together_for_you/core/Widgets/respondAlert.dart';
import 'package:together_for_you/core/utils/styles.dart';

class ServiceProfile extends StatefulWidget {
  const ServiceProfile(
      {super.key,
      required this.email,
      required this.name,
      required this.image,
      required this.speclization,
      required this.price,
      required this.phone,
      required this.id,
      required this.type});
  final String email;
  final String name;
  final String image;
  final String speclization;
  final String price;
  final String phone;
  final String id;
  final String type;

  @override
  State<ServiceProfile> createState() => _ServiceProfileState();
}

class _ServiceProfileState extends State<ServiceProfile> {
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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey.withOpacity(.2),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('requset')
                    .where('userid', isEqualTo: user?.uid)
                    .where('adminid', isEqualTo: widget.id)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  var req = snapshot.data!.docs;
                  return req.isNotEmpty
                      ? Image.asset(
                          'assets/icons/done.png',
                          width: 40,
                          color: Colors.red,
                        )
                      : Image.asset(
                          'assets/icons/done.png',
                          width: 40,
                        );
                },
              ),
              const SizedBox(height: 20),
          ClipRRect(
  borderRadius: BorderRadius.circular(20),
  child: widget.image == ''
      ? Image.asset(
          'assets/icons/profile(1).png',
          width: 140, 
          height: 150, 
          fit: BoxFit.cover, 
        )
      : ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            widget.image,
            width: 140, 
            height: 150, 
            fit: BoxFit.cover, 
          ),
        ),
),

              const SizedBox(height: 10),
              const Rating(
                emptyColor: Colors.blue,
                filledColor: Colors.blue,
                rating: 3,
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue.withOpacity(.1),
                ),
                child: Text(
                  'Name : ${widget.name}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue.withOpacity(.1),
                ),
                child: Text(
                  'Phone : ${widget.phone}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue.withOpacity(.1),
                ),
                child: Text(
                  'Speclization : ${widget.speclization}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue.withOpacity(.1),
                ),
                child: Text(
                  'Price : ${widget.price}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Person')
                    .doc(user?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  var userdata = snapshot.data;
                  return userdata != null
                      ? StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('requset')
                              .where('userid', isEqualTo: user?.uid)
                              .where('adminid', isEqualTo: widget.id)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            var req = snapshot.data!.docs;
                            return req.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: CustomButton(
                                      text: 'Request',
                                      bgcolor: Colors.blue.withOpacity(.3),
                                      onTap: () async {
                                        try {
                                          var documentReference =
                                              await FirebaseFirestore.instance
                                                  .collection('requset')
                                                  .add({
                                            'service': widget.type,
                                            'userid': user?.uid,
                                            'adminid': widget.id,
                                            'adminname': widget.name,
                                            'adminimage': widget.image,
                                            'username': user?.displayName,
                                            'userphone': userdata['phone'],
                                            'userdisability':
                                                userdata['Disabilitytype'],
                                            'status': 'pending',
                                            'userimage': userdata['image']
                                          });
                                          var reqid = documentReference.id;
                                          await documentReference
                                              .update({'docId': reqid});
                                          showSentAlertDialog(context,
                                              title: 'done',
                                              ok: 'ok',
                                              alert: 'Updated Successfuly',
                                              Subtiltle: '', onTap: () {
                                            Navigator.pop(context);
                                          }, subtitle: '');
                                        } catch (e) {
                                          showErrorDialog(
                                              context, e.toString());
                                        }
                                      },
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      'Already have been Requested',
                                      style: getBodyStyle(
                                          color: Colors.blueAccent),
                                    ),
                                  );
                          })
                      : Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
