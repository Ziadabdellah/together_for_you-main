class BusnissSignupstates {}

class AuthInitState extends BusnissSignupstates {}

// login
class LoginLoadingState extends BusnissSignupstates {}

class LoginSuccessState extends BusnissSignupstates {}

class LoginErrorState extends BusnissSignupstates {
  final String error;

  LoginErrorState({required this.error});
}

// register
class RegisterLoadingState extends BusnissSignupstates {}

class RegisterSuccessState extends BusnissSignupstates {}

class RegisterErrorState extends BusnissSignupstates {
  final String error;

  RegisterErrorState({required this.error});
}

//update
class UpdateLoadingState extends BusnissSignupstates {}

class UpdateSuccessState extends BusnissSignupstates {}

class UpdateErrorState extends BusnissSignupstates {
  final String error;

  UpdateErrorState({required this.error});
}

//about
class AboutLoadingState extends BusnissSignupstates {}

class AboutSuccessState extends BusnissSignupstates {}

class AboutErrorState extends BusnissSignupstates {
  final String error;

  AboutErrorState({required this.error});
}
