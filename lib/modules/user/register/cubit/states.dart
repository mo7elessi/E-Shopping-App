
import 'package:e_shopping/model/login_model.dart';

abstract class RegisterStates {}

class RegisterInitial extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final LoginModel? loginModel;

  RegisterSuccessState({this.loginModel});
}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}

class RegisterChangeVisibilityPassword extends RegisterStates {}
