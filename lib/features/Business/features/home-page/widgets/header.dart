import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:together_for_you/core/utils/styles.dart';
import 'package:together_for_you/features/person/features/Home/homePage/widgets/moremenue.dart';

class Header extends StatefulWidget {
  const Header({super.key, required this.type});
  final String type;
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
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

  icon() {
    if (widget.type == 'Nurse') {
      return 'assets/icons/doctor.png';
    } else if (widget.type == 'Driver') {
      return 'assets/icons/driver.png';
    } else if (widget.type == 'Delivery') {
      return 'assets/icons/delivery.png';
    } else {
      return 'assets/icons/woman.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
        child: Container(
          margin: EdgeInsets.only(top: 30),
          height: 182,
          padding: EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3), // shadow color
                spreadRadius: 2, // spread radius
                blurRadius: 5, // blur radius
                offset: Offset(0, 5), // changes position of shadow
              ),
            ],
            color: Colors.grey.withOpacity(.1),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Spacer(),
                  Image.asset(
                    icon(),
                    width: 80,
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        showPopover(
                            arrowHeight: 15,
                            arrowWidth: 30,
                            height: 80,
                            width: 200,
                            backgroundColor: Colors.white,
                            direction: PopoverDirection.bottom,
                            context: context,
                            bodyBuilder: (context) => More());
                      },
                      child: Icon(Icons.more_vert_rounded))
                ],
              ),
              Text(
                'Hello ${user?.displayName}',
                style: getTitleStyle(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Offer Your Service Now !',
                  style: getBodyStyle(),
                ),
              )
            ],
          ),
        ));
  }
}
