import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:together_for_you/features/person/features/Home/homePage/home.dart';
import 'package:together_for_you/features/person/features/profile/profile.dart';
import 'package:together_for_you/features/person/features/specials/specials.dart';

class Navperson extends StatefulWidget {
  const Navperson({super.key});

  @override
  State<Navperson> createState() => _NavpersonState();
}

class _NavpersonState extends State<Navperson> {
  List<Widget> pages = [const Home(), const Specials(), const PersonProfile()];
  int pageindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageindex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Container(
          height: 70,
          margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
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
                icon: const Icon(Icons.favorite_border),
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
