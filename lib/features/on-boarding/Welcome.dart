
import 'package:flutter/material.dart';
import 'package:together_for_you/features/Business/Auth/login/view/BusnissLogin.dart';
import 'package:together_for_you/features/person/Auth/Model/Login/Login.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/Screenshot.png', 
             fit: BoxFit.cover,  
            ),
          ),
          Column(
            children: [
             const SizedBox(height: 400,),
             
           Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
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
                        return const PersonLogin();
                      }),
                    );
                  },
                  child: const Text(
                    'Personal account',
                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.normal),
                  ),
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
                        return const BusnissLogin();
                      }),
                    );
                  },
                  child: const Text(
                    'Business account',
                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

