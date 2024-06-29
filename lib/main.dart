import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:together_for_you/features/Business/Auth/login/stateManagement/loginCubit.dart';
import 'package:together_for_you/features/Business/Auth/signup/stateManagement/auth_cubit.dart';
import 'package:together_for_you/features/person/Auth/FireBase/Login/Login.dart';
import 'package:together_for_you/features/person/Auth/FireBase/Sing_Up/Sign_Up.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:together_for_you/splash_view.dart';

void main() async {
  // ignore: unused_local_variable
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyB6cdglyVtYEyNMWoktjPZ8xiDo5yVUvQk',
        appId: 'com.example.together_for_you',
        messagingSenderId: '16254369463',
        storageBucket: 'together-for-you-d3ed5.appspot.com',
        projectId: 'together-for-you-d3ed5'),
  );

   runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: ((context, child) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => BusnissSignUpCupit(),
              ),
              BlocProvider(
                create: (context) => BusnissLoginCubit(),
              ),
              BlocProvider(
                create: (context) => PersonLoginCubit(),
              ),
              BlocProvider(
                create: (context) => PersonSignUpCupit(),
              ),
            ],
            child: MaterialApp(
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              home: const SplashView(),
            ),
          )),
    );
  }
}













