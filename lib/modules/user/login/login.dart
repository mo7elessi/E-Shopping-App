import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_shopping/modules/user/login/verify_email_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/layout/shop_layout.dart';
import 'package:e_shopping/shared/components/components.dart';
import 'package:e_shopping/shared/components/conestance.dart';
import 'package:e_shopping/shared/network/local/cache_helper.dart';
import 'package:e_shopping/shared/styles/colors.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class Login extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, LoginStates state) {
          if (state is LoginSuccessState) {
            if (state.loginModel!.status) {
              print(state.loginModel!.message);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel!.data.token)
                  .then((value) {
                if (value) {

                  toastMessage(message: state.loginModel!.message);
                  token = state.loginModel!.data.token;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShopLayout(),
                    ),
                    (route) {
                      return false;
                    },
                  );
                }else{
                  toastMessage(message: state.loginModel!.message);
                }
              });
            }
          }
        },
        builder: (BuildContext context, LoginStates state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        inputTextFormField(
                          controller: emailController,
                          keyboard: TextInputType.emailAddress,
                          textLabel: 'E-mail',
                          prefixIcon: Icons.email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email can be not empty';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        inputTextFormField(
                          controller: passwordController,
                          keyboard: TextInputType.visiblePassword,
                          textLabel: 'Password',
                          prefixIcon: Icons.lock,
                          isPassword: LoginCubit.get(context).isPassword,
                          suffixIcon: LoginCubit.get(context).isPassword
                              ? Icons.visibility_off_sharp
                              : Icons.visibility_sharp,
                          suffixIconPressed: () {
                            LoginCubit.get(context).changeIconSuffix();
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).login(
                                  email: emailController.text,
                                  password: passwordController.text);
                              print(
                                  'user data is: ${emailController.text} / ${passwordController.text}');
                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password can be not empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        TextButton(
                          child: const Text('Forget Password?',
                              style: TextStyle(color: primaryColor)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VerifyEmailScreen()));
                          },
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultButtonApp(
                              text: 'Login'.toUpperCase(),
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).login(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  print(
                                    'user data is: ${emailController.text} / ${passwordController.text}}',
                                  );
                                }
                              }),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        defaultLoginUsing(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
