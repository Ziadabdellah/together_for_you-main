import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:together_for_you/features/Business/features/home-page/widgets/AddData.dart';
import 'package:together_for_you/features/Business/features/home-page/widgets/header.dart';
import 'package:together_for_you/features/Business/features/home-page/widgets/services.dart';



class BusinessHome extends StatefulWidget {
  const BusinessHome({super.key});

  @override
  State<BusinessHome> createState() => _BusinessHomeState();
}

class _BusinessHomeState extends State<BusinessHome> {
  // ignore: unused_field
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  // ignore: unused_field
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> subscription;
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

    // if (checkinternet() == 'none') {
    //   showConnectivityDialog(BuildContext context) {
    //     showDialog(
    //       context: context,
    //       builder: (BuildContext context) => AlertDialog(
    //         title: Text('No Internet Connection'),
    //         content: Text('Please check your internet connection.'),
    //         actions: <Widget>[
    //           TextButton(
    //             onPressed: () => Navigator.pop(context),
    //             child: Text('OK'),
    //           ),
    //         ],
    //       ),
    //     );
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Busniss')
                .doc(user?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              var userData = snapshot.data;
              print(user!.email);
              return userData != null
                  ? Column(
                      children: [
                        Header(
                          type: userData['service'],
                        ),
                        AddData(
                          type: userData['service'],
                        ),
                        SimilarSirvices(
                          type: userData['service'],
                        )
                      ],
                    )
                  : Container();
            }),
      ),
    );
  }
}
