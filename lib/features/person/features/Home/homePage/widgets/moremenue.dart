

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:together_for_you/core/functions/route.dart';
import 'package:together_for_you/core/utils/styles.dart';
import 'package:together_for_you/features/on-boarding/Welcome.dart';
import 'package:together_for_you/features/on-boarding/on_boarding_view.dart';

class More extends StatelessWidget {
  const More({Key? key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              push(context, const Welcome());
            },
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person_add_alt),
                  const Gap(10),
                  Text(
                    'Add Account',
                    style: getSmallStyle(),
                  )
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey.withOpacity(0.5)),
          GestureDetector(
            onTap: () {
              _showLogoutConfirmation(context);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout_sharp,
                  color: Colors.red,
                  size: 22,
                ),
                SizedBox(width: 8),
                Text('Log Out',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text(
            'Are You sure?',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _logout(context); 
              },
              child: const Text(
                ' Yes, Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const on_boarding()),
      (Route<dynamic> route) => false,
    );
  }
}
