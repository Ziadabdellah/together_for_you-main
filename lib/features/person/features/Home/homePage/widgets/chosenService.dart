import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:together_for_you/core/functions/route.dart';
import 'package:together_for_you/core/utils/styles.dart';
import 'package:together_for_you/features/person/features/Home/homePage/serviceProfile.dart';

import 'package:together_for_you/features/person/features/Home/homePage/widgets/serviceCard.dart';
class ChosenService extends StatefulWidget {
  const ChosenService({super.key, required this.type});
  final String type;

  @override
  State<ChosenService> createState() => _ChosenServiceState();
}

class _ChosenServiceState extends State<ChosenService> {
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
          title: Text(
            widget.type,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.grey.withOpacity(.2),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Busniss')
                  .where('service', isEqualTo: widget.type)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var services = snapshot.data!.docs;
                // ignore: unnecessary_null_comparison
                return services != null && services.isNotEmpty
                    ? ListView.separated(
                        itemBuilder: ((context, index) {
                          print(services.length);
                          var ser = index < services.length
                              ? services[index].data()
                              : null;
                          return ser != null
                              ? GestureDetector(
                                  onTap: () {
                                    print(ser['email']);
                                    push(
                                      context,
                                      ServiceProfile(
                                        type: widget.type,
                                        id: ser['userid'] ?? '',
                                        email: ser['email'] ?? '',
                                        image: ser['image'] ?? '',
                                        name: ser['name'] ?? '',
                                        phone: ser['phone'] != null
                                            ? ser['phone'].toString()
                                            : '',
                                        price: ser['price'] != null
                                            ? ser['price'].toString()
                                            : '',
                                        speclization: ser['speclization'] ?? '',
                                      ),
                                    );
                                  },
                                  child: ServiceCard(
                                      adminid: ser['userid'],
                                      phone: ser['phone'] ?? '',
                                      type: widget.type,
                                      image: ser['image'] ?? '',
                                      name: ser['name'] ?? '',
                                      price: ser['price'] != null
                                          ? ser['price'].toString()
                                          : '',
                                      cartype: ser['cartype'] ?? '',
                                      Rating: ser['rating'] ?? 0,
                                      sp: ser['speclization'] ?? ''))
                              : Container();
                        }),
                        separatorBuilder: (contexy, index) => const SizedBox(),
                        itemCount: services.length)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text('no providers yet in this service!!',
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
