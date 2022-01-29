import 'package:e_shopping/modules/user/register/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/model/login_model.dart';
import 'package:e_shopping/shared/network/end_points.dart';
import 'package:e_shopping/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;
  IconData suffixIcon = Icons.visibility_off_sharp;
  bool isPassword = true;

  void changeIconSuffix() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_off_sharp : Icons.visibility_sharp;
    emit(RegisterChangeVisibilityPassword());
  }

  void register({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
   // emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
      },
    ).then((value) {
      print('${value.data}');
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.message);
      print(loginModel!.status);
      emit(RegisterSuccessState(loginModel: loginModel));
    }).catchError((onError) {
      print('error in register ' + onError.toString());
      emit(RegisterErrorState(onError.toString()));
    });
  }
}
