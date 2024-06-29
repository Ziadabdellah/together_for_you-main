import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:together_for_you/features/person/Auth/State_Management/State_Login/Login.dart';

class PersonLoginCubit extends Cubit<PersonLoginstates> {
  PersonLoginCubit() : super(AuthInitState());
  //---------------------------Login-----------------------------------//
  login({required String email, required String password}) async {
    emit(LoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        // ignore: unused_local_variable
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
