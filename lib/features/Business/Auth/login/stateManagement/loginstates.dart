class BusnissLoginstates {}

class AuthInitState extends BusnissLoginstates {}

// login
class LoginLoadingState extends BusnissLoginstates {}

class LoginSuccessState extends BusnissLoginstates {}

class LoginErrorState extends BusnissLoginstates {
  final String error;

  LoginErrorState({required this.error});
}
