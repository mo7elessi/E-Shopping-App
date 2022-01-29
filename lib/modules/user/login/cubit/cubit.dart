import 'package:e_shopping/modules/user/login/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/model/login_model.dart';
import 'package:e_shopping/shared/network/end_points.dart';
import 'package:e_shopping/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;
  IconData suffixIcon = Icons.visibility_off_sharp;
  bool isPassword = true;

  void changeIconSuffix() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_off_sharp : Icons.visibility_sharp;
    emit(LoginChangeVisibilityPassword());
  }

  void login({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel: loginModel));
    }).catchError((onError) {
      print('error in login: ' + onError.toString());
      emit(LoginErrorState(onError.toString(),loginModel));
    });
  }

  void verifyEmail({required String email}) {
    emit(VerifyEmailLoadingState());
    DioHelper.postData(
      url: VERIFY_EMAIL,
      data: {
        'email': email,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(VerifyEmailSuccessState(loginModel: loginModel));
    }).catchError((onError) {
      print('error in send email ' + onError.toString());
      emit(VerifyEmailErrorState(onError.toString(),loginModel));
    });
  }

  void verifyCode({required String email, required dynamic code}) {
    emit(VerifyCodeLoadingState());
    DioHelper.postData(
      url: VERIFY_CODE,
      data: {
        'email': email,
        'code': code
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(VerifyCodeSuccessState(loginModel: loginModel));
    }).catchError((onError) {
      print('error in send code:  ' + onError.toString());
      emit(VerifyCodeErrorState(onError.toString()));
    });
  }

  void resetPassword(
      {required String email, required String code, required String password}) {
    DioHelper.postData(
      url: RESET_PASSWORD,
      data: {
        'email': email,
        'code': code,
        'password': password
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.status);
      print(loginModel!.message);
      emit(ResetPasswordSuccessState(loginModel: loginModel));
    }).catchError((onError) {
      print('error in send code:  ' + onError.toString());
      emit(ResetPasswordErrorState(onError.toString()));
    });
  }
}
