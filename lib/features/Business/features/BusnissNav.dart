import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:together_for_you/features/Business/features/home-page/busnissHome.dart';
import 'package:together_for_you/features/Business/features/notificatoins/business_notifications.dart';
import 'package:together_for_you/features/Business/features/profile/business_profile.dart';


class BusnissNav extends StatefulWidget {
  const BusnissNav({super.key});

  @override
  State<BusnissNav> createState() => _BusnissNavState();
}

class _BusnissNavState extends State<BusnissNav> {
  List<Widget> pages = [
    const BusinessHome(),
    const BusinessNotification(),
    const BusinessProfile()
  ];
  int pageindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageindex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Container(
          height: 70,
          margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(40),
            ),
            color: Colors.blue.withOpacity(.2),
          ),
          child: DotNavigationBar(
            curve: Curves.linear,

            borderRadius: 300,
            enableFloatingNavBar: false,
            backgroundColor: Colors.transparent,
            itemPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 0),

            currentIndex: pageindex,
            onTap: (index) {
              setState(() {
                pageindex = index;
              });
            },
            // dotIndicatorColor: Colors.black,
            items: [
              /// Home
              DotNavigationBarItem(
                icon: const Icon(Icons.home),
                selectedColor: Colors.purple,
              ),

              /// Likes
              DotNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/bell.png',
                  width: 25,
                ),
                selectedColor: Colors.pink,
              ),

              /// Profile
              DotNavigationBarItem(
                icon: const Icon(Icons.person),
                selectedColor: Colors.teal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
