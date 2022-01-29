import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/layout/shop_layout.dart';
import 'package:e_shopping/shared/components/components.dart';
import 'package:e_shopping/shared/components/conestance.dart';
import 'package:e_shopping/shared/network/local/cache_helper.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class Signup extends StatelessWidget {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool isMan = true;
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (BuildContext context, RegisterStates state) {
        if (state is RegisterSuccessState) {
          if (state.loginModel!.status) {
            print(state.loginModel!.message);
            CacheHelper.saveData(
                    key: 'token', value: state.loginModel!.data.token)
                .then((value) {
              if (value) {
                toastMessage(
                    message: state.loginModel!.message, color: Colors.green);
                token = state.loginModel!.data.token;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopLayout(),
                  ),
                  (route) {
                    return false;
                  },
                );
              }
            });
          } else {
            print('error in signup'+state.loginModel!.message);
            toastMessage(
                message: state.loginModel!.message, color: Colors.red);
          }
        }
      },
      builder: (BuildContext context, RegisterStates state) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  inputTextFormField(
                    controller: usernameController,
                    keyboard: TextInputType.name,
                    textLabel: 'Username',
                    prefixIcon: Icons.person,
                    //   onChanged: () {},
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'username can be not empty';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  inputTextFormField(
                    controller: emailController,
                    keyboard: TextInputType.emailAddress,
                    textLabel: 'Email address',
                    prefixIcon: Icons.email,
                    //   onChanged: () {},
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'email can be not empty';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  inputTextFormField(
                    controller: phoneController,
                    keyboard: TextInputType.phone,
                    textLabel: 'Phone',
                    prefixIcon: Icons.phone,
                    //  onChanged: () {},
                    validator: (value) {
                      if (value.isEmpty) {
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
                    isPassword: RegisterCubit.get(context).isPassword,
                    suffixIcon: RegisterCubit.get(context).isPassword
                        ? Icons.visibility_off_sharp
                        : Icons.visibility_sharp,
                    suffixIconPressed: () {
                      RegisterCubit.get(context).changeIconSuffix();
                    },
                    // onChanged: () {},
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
                    controller: confirmPasswordController,
                    keyboard: TextInputType.visiblePassword,
                    textLabel: 'Confirm password',
                    prefixIcon: Icons.lock,
                    isPassword: isPassword,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please confirm password';
                      } else if (value != passwordController.text) {
                        return 'passwords is not matches';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  defaultButtonApp(
                      text: 'Signup'.toUpperCase(),
                      function: () {
                        if (formKey.currentState!.validate()) {
                          print('username is: ${usernameController.text}');
                          RegisterCubit.get(context).register(
                            email: emailController.text,
                            password: passwordController.text,
                            phone: phoneController.text,
                            name: usernameController.text,
                          );
                        }
                      }),
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
  }
}
