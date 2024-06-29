
import 'package:bloc/bloc.dart';

class AuthStates extends StateStreamable<AuthStates> {
  final String message;

  AuthStates({this.message = ''});

  @override
  Stream<AuthStates> get stream => throw UnimplementedError();

  @override
  // ignore: override_on_non_overriding_member
  void dispose() {}

  @override
  // TODO: implement state
  AuthStates get state => throw UnimplementedError();
}

// Auth states
class AuthInitState extends AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthSuccessState extends AuthStates {}

class AuthFailureState extends AuthStates {
  final String error;
  AuthFailureState({required this.error});
}

// Update states
class UpdateLoadingState extends AuthStates {}

class UpdateSucessState extends AuthStates {}

class UpdateErrorState extends AuthStates {
  final String error;

  UpdateErrorState({required this.error});
}

// Logout states
class LogoutLoadingState extends AuthStates {
  LogoutLoadingState({String message = ''}) : super(message: message);
}

class LogoutSuccessState extends AuthStates {
  LogoutSuccessState({String message = ''}) : super(message: message);
}

class LogoutErrorState extends AuthStates {
  final String error;

  LogoutErrorState({required this.error, String message = ''})
      : super(message: message);
}
