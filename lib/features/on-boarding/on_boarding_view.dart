import 'package:flutter/material.dart';
import 'package:together_for_you/features/on-boarding/Welcome.dart';

// ignore: camel_case_types
class on_boarding extends StatelessWidget {
  const on_boarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 600,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                      'assets/Screenshot_2023-12-29_224235-removebg-preview.png'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MaterialButton(
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                height: 50,
                color: Colors.blue[200],
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return const Welcome();
                    }),
                  );
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
