
import 'package:flutter/material.dart';
import 'package:together_for_you/features/on-boarding/on_boarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds:5),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const on_boarding()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/Screenshot_2023-12-29_224235-removebg-preview.png',
          width: 250,
        ),
      ),
    );
  }
}
