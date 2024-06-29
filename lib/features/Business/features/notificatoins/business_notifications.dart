import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


import 'package:together_for_you/core/utils/styles.dart';
import 'package:together_for_you/features/Business/features/notificatoins/widget/notification_card.dart';

class BusinessNotification extends StatefulWidget {
  const BusinessNotification({super.key});

  @override
  State<BusinessNotification> createState() => _BusinessNotificationState();
}

class _BusinessNotificationState extends State<BusinessNotification> {
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
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 50,
                color: Colors.grey.withOpacity(.2),
                child: Text('Notifications', style: getTitleStyle()),
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('requset')
                    .where('adminid', isEqualTo: user?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var requests = snapshot.data!.docs;
                  // ignore: unnecessary_null_comparison
                  return requests != null && requests.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var req = index < requests.length
                                    ? requests[index].data()
                                    : null;
                                return req != null
                                    ? NotificationCard(
                                        image: req['userimage'] ?? '',
                                        reqid: req['docId'] ?? '',
                                        userid: req['userid'] ?? '',
                                        username: req['username'] ?? '',
                                        userphone: req['userphone'] ?? '',
                                        disability: req['userdisability'] ?? '',
                                        adminid: req['adminid'] ?? '',
                                        adminname: req['adminname'] ?? '')
                                    : Container();
                              },
                              separatorBuilder: (context, index) =>
                                  const Gap(0),
                              itemCount: requests.length),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Gap(300),
                            Center(
                              child: Text('There is no Nottifications yet!!',
                                  style: getTitleStyle(color: Colors.indigo)),
                            ),
                          ],
                        );
                }),
          ],
        ),
      )),
    );
  }
}
