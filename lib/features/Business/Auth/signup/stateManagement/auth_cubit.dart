import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:together_for_you/features/Business/Auth/signup/stateManagement/auth_states.dart';

class BusnissSignUpCupit extends Cubit<BusnissSignupstates> {
  BusnissSignUpCupit() : super(AuthInitState());
  //---------------------------regester-----------------------------------//
  ///---------Admin sign up
  regestirAdmin(
      {required String name,
      required String email,
      required String age,
      required String gender,
      required String Address,
      required String password,
      required String phone,
      required String service}) async {
    emit(RegisterLoadingState());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;
      user.updateDisplayName(name);

      // firestore

      FirebaseFirestore.instance.collection('Busniss').doc(user.uid).set({
        'userid': user.uid,
        'name': name,
        'image': null,
        'email': email,
        'phone': phone,
        'address': Address,
        'service': service,
        'speclization': null,
        'price': null,
        'age': age,
        'gender': gender,
        'carType': null,
        'carNumber': null,
        'rating': 3
      }, SetOptions(merge: true));

      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterErrorState(error: 'Your password is waek!!!'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterErrorState(error: 'Email is already in use'));
      }
    } catch (e) {
      emit(RegisterErrorState(
          error: 'A proplem Accured please try again later'));
    }
  }
}
