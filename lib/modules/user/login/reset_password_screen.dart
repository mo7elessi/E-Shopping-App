import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_shopping/modules/user/login/tabs.dart';
import 'package:e_shopping/modules/user/register/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ResetPasswordScreen extends StatelessWidget {
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  late final String email;
  late final String code;
  ResetPasswordScreen(this.email, this.code);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (BuildContext context, LoginStates state) {
        if (state is ResetPasswordSuccessState) {
          toastMessage(message: state.loginModel!.message);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Tabs(),
            ),
            (route) {
              return false;
            },
          );
        }
      },
      builder: (BuildContext context, LoginStates state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Reset Password'),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color:Colors.black54),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Text(
                    'please enter new password',
                    style: TextStyle(fontSize: 14.0, height: 1.3,color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  inputTextFormField(
                    controller: passwordController,
                    keyboard: TextInputType.visiblePassword,
                    textLabel: 'New Password',
                    prefixIcon: Icons.lock,
                    isPassword: RegisterCubit.get(context).isPassword,
                    suffixIcon: RegisterCubit.get(context).isPassword
                        ? Icons.visibility_off_sharp
                        : Icons.visibility_sharp,
                    suffixIconPressed: () {
                      RegisterCubit.get(context).changeIconSuffix();
                    },
                    onChanged: () {},
                    onSubmit: (value) {
                      if (formKey.currentState!.validate()) {}
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'password can be not empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  inputTextFormField(
                    controller: cpasswordController,
                    keyboard: TextInputType.visiblePassword,
                    textLabel: 'Confirm Password',
                    prefixIcon: Icons.lock,
                    isPassword: RegisterCubit.get(context).isPassword,
                    suffixIcon: RegisterCubit.get(context).isPassword
                        ? Icons.visibility_off_sharp
                        : Icons.visibility_sharp,
                    suffixIconPressed: () {
                      RegisterCubit.get(context).changeIconSuffix();
                    },
                    onChanged: () {},
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'password can be not empty';
                      }
                      if (cpasswordController.text !=
                          cpasswordController.text) {
                        return 'passwords is not matches';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  ConditionalBuilder(
                    condition: state is! VerifyCodeLoadingState,
                    builder: (context) => defaultButtonApp(
                        text: 'Save'.toUpperCase(),
                        function: () {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).resetPassword(
                                email: email,
                                code: code,
                                password: passwordController.text);
                          }
                        }),
                    fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
