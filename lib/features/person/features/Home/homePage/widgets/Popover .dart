import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:together_for_you/core/functions/route.dart';
import 'package:together_for_you/core/utils/styles.dart';

import 'package:together_for_you/features/person/features/Home/homePage/nottificationPage.dart';
import 'package:together_for_you/features/person/features/Home/homePage/widgets/moremenue.dart';

class Popover extends StatefulWidget {
  const Popover({Key? key}) : super(key: key);

  @override
  State<Popover> createState() => _PopoverState();
}

class _PopoverState extends State<Popover> {
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
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        height: 130,
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
          color: Color.fromARGB(255, 212, 211, 211).withOpacity(0.1),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to notification page
                    push(context, const NottificationPage());
                  },
                  child: Image.asset(
                    'assets/icons/bell.png',
                    width: 30,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    showPopover(
                      context: context,
                      bodyBuilder: (context) => const More(),
                      direction: PopoverDirection.top,
                      width: 200,
                      height: 100,
                      arrowHeight: 10,
                      arrowWidth: 20,
                    );
                  },
                  child: const Icon(Icons.more_vert_rounded),
                ),
              ],
            ),
            Text(
              'Hello ${user?.displayName ?? 'User'} !!',
              style: getTitleStyle(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Request Your Service Now',
                style: getBodyStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
    
 

