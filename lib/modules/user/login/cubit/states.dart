import 'package:e_shopping/model/login_model.dart';

abstract class LoginStates {}

class LoginInitial extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel? loginModel;

  LoginSuccessState({this.loginModel});
}

class LoginErrorState extends LoginStates {
  final String error;
  final LoginModel? loginModel;

  LoginErrorState(this.error,this.loginModel);
}

class LoginChangeVisibilityPassword extends LoginStates {}

class VerifyEmailLoadingState extends LoginStates {}

class VerifyEmailSuccessState extends LoginStates {
  final LoginModel? loginModel;

  VerifyEmailSuccessState({this.loginModel});
}

class VerifyEmailErrorState extends LoginStates {
  final String error;
  final LoginModel? loginModel;

  VerifyEmailErrorState(this.error,this.loginModel);
}


class VerifyCodeLoadingState extends LoginStates {}

class VerifyCodeSuccessState extends LoginStates {
  final LoginModel? loginModel;

  VerifyCodeSuccessState({this.loginModel});
}

class VerifyCodeErrorState extends LoginStates {
  final String error;

  VerifyCodeErrorState(this.error);
}

class ResetPasswordLoadingState extends LoginStates {}

class ResetPasswordSuccessState extends LoginStates {
  final LoginModel? loginModel;

  ResetPasswordSuccessState({this.loginModel});
}

class ResetPasswordErrorState extends LoginStates {
  final String error;

  ResetPasswordErrorState(this.error);
}