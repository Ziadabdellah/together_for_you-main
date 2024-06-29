import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:together_for_you/core/utils/styles.dart';

class NottificationPage extends StatefulWidget {
  const NottificationPage({super.key});

  @override
  State<NottificationPage> createState() => _NottificationPageState();
}

class _NottificationPageState extends State<NottificationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          centerTitle: true,
          title: const Text(
            'Nottification',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.grey.withOpacity(.2),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('requset')
                  .where('userid', isEqualTo: user?.uid)
                  .where('status', isNotEqualTo: 'pending')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                var services = snapshot.data!.docs;
                // ignore: unnecessary_null_comparison
                return services != null && services.isNotEmpty
                    ? ListView.separated(
                        itemBuilder: ((context, index) {
                          var ser = index < services.length
                              ? services[index].data()
                              : null;
                          return ser != null
                              ? Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: ser['status'] == 'Accepted'
                                              ? Colors.blue.withOpacity(.2)
                                              : Colors.red.withOpacity(
                                                  .2), // shadow color
                                          spreadRadius: 5, // spread radius
                                          blurRadius: 3, // blur radius
                                          offset: const Offset(0, 5),
                                          // changes position of shadow
                                        ),
                                      ],
                                      color: ser['status'] == 'Accepted'
                                          ? Colors.blue.withOpacity(.2)
                                          : Colors.red.withOpacity(.2),
                                      borderRadius: BorderRadius.circular(40),
                                      border: Border.all(
                                          color: Colors.black.withOpacity(.3))),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: services[0]
                                                        ['adminimage'] ==
                                                    ''
                                                ? const AssetImage(
                                                        'assets/icons/profile(1).png')
                                                    as ImageProvider<Object>
                                                : NetworkImage(services[0]
                                                            ['adminimage']
                                                        as String)
                                                    as ImageProvider<Object>),
                                      ),
                                      const Gap(20),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                '${ser['service']} : ${ser['adminname']}'),
                                            const Gap(2),
                                            Text(
                                              ser['status'],
                                              style:
                                                  getSmallStyle(fontSize: 14),
                                            ),
                                            const Gap(2),
                                            if (ser['status'] == 'Accepted')
                                              Text(
                                                'The Provider will contact you in 5s',
                                                style:
                                                    getSmallStyle(fontSize: 12),
                                              ),
                                            if (ser['status'] == 'Declined')
                                              const Text(
                                                  'Sorry this provider isnt available !!'),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: ser['status'] == 'Accepted'
                                            ? const Icon(Icons.done_all_outlined,
                                                color: Colors.indigo)
                                            : const Icon(Icons.not_interested_rounded,
                                                color: Colors.red),
                                      )
                                    ],
                                  ),
                                )
                              : Container();
                        }),
                        separatorBuilder: (contexy, index) => const Gap(15),
                        itemCount: services.length)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text('There is no Nottifications yet!!',
                                style: getTitleStyle(color: Colors.indigo)),
                          ),
                        ],
                      );
              }),
        ),
      ),
    );
  }
}
