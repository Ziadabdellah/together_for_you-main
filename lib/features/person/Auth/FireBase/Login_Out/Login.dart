import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:together_for_you/features/person/Auth/State_Management/State_Login_Out/Login_Out.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitState());

////// LogOut
  Future<void> logout() async {
    emit(LogoutLoadingState());
    try {
      await FirebaseAuth.instance.signOut();
      emit(LogoutSuccessState(message: 'Logged out successfully'));
    } catch (e) {
      emit(LogoutErrorState(error: e.toString()));
    }
  }
}
