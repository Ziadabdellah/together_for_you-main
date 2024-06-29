import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:together_for_you/features/Business/Auth/login/stateManagement/loginstates.dart';

class BusnissLoginCubit extends Cubit<BusnissLoginstates> {
  BusnissLoginCubit() : super(AuthInitState());
  //---------------------------Login-----------------------------------//
  login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        User user = credential.user!;
      }
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginErrorState(error: 'user not found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginErrorState(error: 'wrong password'));
      } else {
        emit(LoginErrorState(
            error: 'there is a proplem in logging in pleasr try again later'));
      }
    }
  }
}
