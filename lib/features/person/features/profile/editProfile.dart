import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:together_for_you/core/Widgets/custom_button.dart';
import 'package:together_for_you/core/Widgets/dialogs.dart';
import 'package:together_for_you/core/Widgets/respondAlert.dart';
import 'package:together_for_you/core/functions/email_validator.dart';
import 'package:together_for_you/core/utils/styles.dart';
import 'package:together_for_you/features/person/features/nav.dart';

class EditProfilePerson extends StatefulWidget {
  const EditProfilePerson({super.key});

  @override
  State<EditProfilePerson> createState() => _EditProfilePersonState();
}

class _EditProfilePersonState extends State<EditProfilePerson> {
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

  late String image;

  File? file;
  String? profileUrl;
  final FirebaseStorage _storage = FirebaseStorage.instanceFor(
      bucket: 'gs://together-for-you-d3ed5.appspot.com');
  Future<String> uploadImageToFireStore(File image) async {
    try {
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

      String imagePath = 'Personimages/${_auth.currentUser!.uid}/$timestamp';

      Reference ref = _storage.ref().child(imagePath);
      SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
      await ref.putFile(image, metadata);
      String url = await ref.getDownloadURL();

      await addImageToFirestore(imageUrl: url);

      return url;
    } catch (e) {
      print('Error during image upload to Firestore: $e');
      return '';
    }
  }

  Future<void> addImageToFirestore({required String imageUrl}) async {
    try {
      final CollectionReference imageCollection =
          FirebaseFirestore.instance.collection('Person');

      await imageCollection.doc(user!.uid).set({
        'image': imageUrl,
      }, SetOptions(merge: true));

      print('Image added to Firestore: $imageUrl');
    } catch (e) {
      print('Error adding image to Firestore: $e');
    }
  }

  Future<void> _showUploadoptions() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Photo Source"),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                final pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    file = File(pickedFile.path);
                  });
                }
                final imageUrl = await uploadImageToFireStore(file!);
                print('Image uploaded successfully: $imageUrl');
              },
              child: const Text("Gallery"),
            ),
            TextButton(
              onPressed: () async {
                final pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  setState(() {
                    file = File(pickedFile.path);
                  });
                }
                final imageUrl = await uploadImageToFireStore(file!);
                // ignore: avoid_print
                print('Image uploaded successfully: $imageUrl');
                //   pickVideo(ImageSource.camera);
              },
              child: const Text("Camera"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController disabilityController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    void updatePerson(
        {required String name,
        required String email,
        required String phone,
        required String address,
        required String disability}) {
      try {
        FirebaseFirestore.instance.collection('Person').doc(user?.uid).set({
          'name': name,
          'email': email,
          'phone': phone,
          'address': address,
          'Disabilitytype': disability
        }, SetOptions(merge: true));
        showSentAlertDialog(context,
            title: 'done',
            ok: 'ok',
            alert: 'Updated Successfuly',
            Subtiltle: '',onTap: () {
      Navigator.pop(context); // Close the dialog
      Navigator.push( // Navigate to the next screen
        context,
        MaterialPageRoute(builder: (context) => Navperson()),
      );
    }, subtitle: '');
      } catch (e) {
        showErrorDialog(context, e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: getTitleStyle(),
        ),
        backgroundColor: Colors.grey.withOpacity(.2),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: SingleChildScrollView(
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
                  nameController.text = userData[0]['name'] != null
                      ? userData[0]['name'].toString()
                      : '';
                  emailController.text = userData[0]['email'] != null
                      ? userData[0]['email'].toString()
                      : '';
                  phoneController.text = userData[0]['phone'] != null
                      ? userData[0]['phone'].toString()
                      : '';
                  disabilityController.text =
                      userData[0]['Disabilitytype'] != null
                          ? userData[0]['Disabilitytype'].toString()
                          : '';
                  addressController.text = userData[0]['address'] != null
                      ? userData[0]['address'].toString() : '';
                  // ignore: avoid_print
                  print(userData);
                  // ignore: avoid_print
                  print(user?.uid);
                  // ignore: unnecessary_null_comparison
                  return userData[0] != null
                      ? Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                      radius: 80,
                                      backgroundColor:
                                          Colors.blue.withOpacity(.1),
                                      backgroundImage: userData[0]['image'] ==
                                              null
                                          ? const AssetImage(
                                                  'assets/icons/profile(1).png')
                                              as ImageProvider<Object>
                                          : NetworkImage(userData[0]['image']
                                                  as String)
                                              as ImageProvider<Object>),
                                  Positioned(
                                    bottom: -10,
                                    right: 5,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: IconButton(
                                          onPressed: () {
                                            _showUploadoptions();
                                          },
                                          icon: const Icon(
                                            Icons.camera_alt_rounded,
                                            color: Colors.blue,
                                            size: 20,
                                          )),
                                    ),
                                  )
                                ],
                              ),
                              const Gap(20),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    label: const Text('Name'),
                                    // labelStyle: getBodyStyle(),
                                    hintText: 'Enter Your name  ',
                                  ),
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your name';
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
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    label: const Text('Email Address'),
                                    // labelStyle: getBodyStyle(),
                                    hintText: 'Enter Your email  ',
                                  ),
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your email';
                                    } else if (!emailValidate(value)) {
                                      return 'the email is wrong!!';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    label: const Text('Phone Number'),
                                    // labelStyle: getBodyStyle(),
                                    hintText: 'Enter Your phone  ',
                                  ),
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your phone';
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
                                  controller: disabilityController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    label: const Text('Disability Type'),
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
                                  controller: addressController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    label: const Text('Address'),
                                    // labelStyle: getBodyStyle(),
                                    hintText: 'Enter Your address  ',
                                  ),
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your address';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              CustomButton(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      updatePerson(
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        address: addressController.text,
                                        disability: disabilityController.text,
                                      );
                                    }
                                  },
                                  text: 'Update',
                                  bgcolor: Colors.blue.withOpacity(.5))
                            ],
                          ),
                        )
                      : Container();
                }),
          ),
        ),
      ),
    );
  }
}
