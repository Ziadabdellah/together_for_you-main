import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:together_for_you/core/Widgets/custom_button.dart';
import 'package:together_for_you/core/Widgets/dialogs.dart';
import 'package:together_for_you/core/Widgets/respondAlert.dart';
import 'package:together_for_you/core/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard(
      {super.key,
      required this.username,
      required this.userphone,
      required this.disability,
      required this.adminid,
      required this.adminname,
      required this.userid,
      required this.reqid,
      required this.image});
  final String username;
  final String userphone;
  final String disability;
  final String adminid;
  final String userid;
  final String reqid;
  final String image;

  final String adminname;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    void Respond(int type) {
      if (type == 2) {
        try {
       
          // ignore: unused_local_variable
          var request = FirebaseFirestore.instance
              .collection('requset')
              .doc(widget.reqid)
              .update({'status': 'Accepted'});
          showSentAlertDialog(context,
              title: 'done',
              ok: 'ok',
              alert: 'the request have been Approved',
              subtitle: '', onTap: () {
            Navigator.pop(context);
          }, Subtiltle: '', );
        } catch (e) {
          showErrorDialog(context, e.toString());
        }
      } else {
        try {
        
          // ignore: unused_local_variable
          var request = FirebaseFirestore.instance
              .collection('requset')
              .doc(widget.reqid)
              .update({'status': 'Declined'});
          showSentAlertDialog(context,
              title: 'done',
              ok: 'ok',
              alert: 'the request have been declined',
              Subtiltle: '', onTap: () {
            Navigator.pop(context);
          }, subtitle: '');
        } catch (e) {
          showErrorDialog(context, e.toString());
        }
      }
    }

    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.3), // shadow color
              spreadRadius: 5, // spread radius
              blurRadius: 3, // blur radius
              offset: const Offset(0, 5),
              // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black.withOpacity(.3))),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  backgroundColor: Colors.blue.withOpacity(.1),
                  radius: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(.1),
                      backgroundImage: widget.image == ''
                          ? const AssetImage(
                              'assets/icons/profile(1).png',
                            ) as ImageProvider<Object>
                          : NetworkImage(widget.image as String)
                              as ImageProvider<Object>,
                      radius: 40,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${widget.username}',
                      style: getBodyStyle(),
                    ),
                    const Gap(10),
                    Text(
                      'Phone: ${widget.userphone}',
                      style: getBodyStyle(),
                    ),
                    const Gap(10),
                    Text(
                      'Disability: ${widget.disability} ',
                      style: getBodyStyle(),
                    ),
                  ],
                ),
              )
            ],
          ),
          const Gap(30),
          StreamBuilder(
              // ignore: unnecessary_null_comparison
              stream: widget.reqid != null && widget.reqid.isNotEmpty
                  ? FirebaseFirestore.instance
                      .collection('requset')
                      .doc(widget.reqid)
                      .snapshots()
                  : null,
              builder: (context, snapshot) {
                print(snapshot.data);
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                var req = snapshot.data;
                return req != null
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, bottom: 5),
                        child: Row(
                          children: [
                            if (req['status'] != 'pending') Text(req['status']),
                            if (req['status'] == 'pending')
                              CustomButton(
                                width: 90,
                                text: "Decline",
                                style: getSmallStyle(),
                                bgcolor: const Color.fromARGB(255, 124, 194, 251),
                                onTap: () {
                                  Respond(1);
                                },
                              ),
                            const Spacer(),
                            if (req['status'] == 'pending')
                              CustomButton(
                                width: 90,
                                text: "Accept",
                                bgcolor: const Color.fromARGB(255, 124, 194, 251),
                                onTap: () {
                                  Respond(2);
                                },
                              ),
                            const Spacer(),
                            if (req['status'] == 'pending' ||
                                req['status'] != 'pending')
                              CustomButton(
                                width: 90,
                                text: "Call",
                                bgcolor: const Color.fromARGB(255, 124, 194, 251),
                                onTap: () async {
                                  var url =
                                      Uri.parse("tel:${widget.userphone}");
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                              ),
                          ],
                        ),
                      )
                    : Container();
              })
        ],
      ),
    );
  }
}
