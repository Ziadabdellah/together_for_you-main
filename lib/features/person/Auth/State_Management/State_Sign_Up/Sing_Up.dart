

class PersonSignupstates {}

class AuthInitState extends PersonSignupstates {}

// register
class RegisterLoadingState extends PersonSignupstates {}

class RegisterSuccessState extends PersonSignupstates {}

class RegisterErrorState extends PersonSignupstates {
  final String error;

  RegisterErrorState({required this.error});
}

//update
class UpdateLoadingState extends PersonSignupstates {}

class UpdateSuccessState extends PersonSignupstates {}

class UpdateErrorState extends PersonSignupstates {
  final String error;

  UpdateErrorState({required this.error});
}

//about
class AboutLoadingState extends PersonSignupstates {}

class AboutSuccessState extends PersonSignupstates {}

class AboutErrorState extends PersonSignupstates {
  final String error;

  AboutErrorState({required this.error});
}