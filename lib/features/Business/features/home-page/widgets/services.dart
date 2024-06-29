import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:together_for_you/core/utils/styles.dart';
import 'package:together_for_you/features/Business/features/home-page/widgets/SerCard.dart';

class SimilarSirvices extends StatefulWidget {
  const SimilarSirvices({super.key, required this.type});
  final String type;

  @override
  State<SimilarSirvices> createState() => _SimilarSirvicesState();
}

class _SimilarSirvicesState extends State<SimilarSirvices> {
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
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'See All Services:',
                style: getTitleStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Busniss')
                  .where('email', isNotEqualTo: user?.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                var UserConfirmation = snapshot.data!.docs;
                if (UserConfirmation.isEmpty ||
                    UserConfirmation[0]['email'] == null) {
                  return Container();
                }

                // ignore: unnecessary_null_comparison
                return (UserConfirmation[0] != null &&
                        UserConfirmation.isNotEmpty)
                    ? SizedBox(
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('Busniss')
                                .where('service', isEqualTo: widget.type)
                                .where('email', isNotEqualTo: user?.email)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              var Busniss = snapshot.data!.docs;
                              return (Busniss.isNotEmpty)
                                  ? ListView.separated(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        var admin = index < Busniss.length
                                            ? Busniss[index].data()
                                            : null;
                                        return admin != null
                                            ? SerCard(
                                                type: widget.type.toString() ?? '',
                                                cartype: admin['carType'] ?? '',
                                                image: admin['image'] ?? '',
                                                name: admin['name'] ?? '',
                                                sp: admin['speclization'] ?? '',
                                                price: admin['price'] ?? '',
                                                Rating: admin['rating'] ?? 0)
                                            : Container();
                                      },
                                      separatorBuilder: ((context, index) =>
                                          const Gap(0)),
                                      itemCount: Busniss.length)
                                  : const Center(
                                      child: Text(
                                          'there are no simillar services'),
                                    );
                            }),
                      )
                    : Container();
              })
        ],
      ),
    );
  }
}
