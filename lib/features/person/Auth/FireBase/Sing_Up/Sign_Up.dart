import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:together_for_you/features/person/Auth/State_Management/State_Sign_Up/Sing_Up.dart';

class PersonSignUpCupit extends Cubit<PersonSignupstates> {
  PersonSignUpCupit() : super(PersonSignupstates());
  regestirPerson(
      {required String name,
      required String email,
      required String age,
      // ignore: non_constant_identifier_names
      required String Gender,
      // ignore: non_constant_identifier_names
      required String Address,
      required String password,
      required String phone,
      // ignore: non_constant_identifier_names
      required String Disabilitytype}) async {
    emit(RegisterLoadingState());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;
      await sendVerificationEmail(user.email!);
      user.updateDisplayName(name);

      // firestore

      FirebaseFirestore.instance.collection('Person').doc(user.uid).set({
        'name': name,
        'image': null,
        'email': email,
        'phone': phone,
        'address': Address,
        'Disabilitytype': Disabilitytype,
        'age': age,
        'Gender': Gender
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
Future<void> sendVerificationEmail(String email) async {
  var actionCodeSettings = ActionCodeSettings(
    url: 'https://Application@together-for-you-d3ed5.firebaseapp.com/emailVerification',
    handleCodeInApp: true,
  );

  try {
    await FirebaseAuth.instance.sendSignInLinkToEmail(
      email: email,
      actionCodeSettings: actionCodeSettings,
    );
    // ignore: avoid_print
    print('A verification link has been sent to $email');
  } catch (e) {
    // ignore: avoid_print
    print('An error occurred while sending the verification link: $e');
  }
}
