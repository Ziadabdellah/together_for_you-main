class PersonLoginstates {}

class AuthInitState extends PersonLoginstates {}

// login
class LoadingState extends PersonLoginstates {}

class LoginSuccessState extends PersonLoginstates {}

class LoginErrorState extends PersonLoginstates {
  final String error;

  LoginErrorState({required this.error});
}