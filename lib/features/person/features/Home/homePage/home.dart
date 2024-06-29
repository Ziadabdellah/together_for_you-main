import 'package:flutter/material.dart';
import 'package:together_for_you/features/person/features/Home/homePage/widgets/Popover%20.dart';
import 'package:together_for_you/features/person/features/Home/homePage/widgets/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [Popover(), Services()],
          ),
        ),
      ),
    );
  }
}