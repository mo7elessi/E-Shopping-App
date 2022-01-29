import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/shared/components/components.dart';
import 'package:e_shopping/shared/components/conestance.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var usernameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();

    var formKey = GlobalKey<FormState>();
    bool isPassword = true;

    return BlocConsumer<ShopCubit, ShopState>(
        listener: (BuildContext context, ShopState? state) {
      if (state is ShopLoginModelSuccessState) {
        print('sucess');
      }
    }, builder: (BuildContext context, state) {
      var user = ShopCubit.get(context).loginModel;
      usernameController.text = user!.data.name;
      emailController.text = user.data.email;
      phoneController.text = user.data.phone;
      print('username of state is: ${user.data.name.toString()}');
      if (state is ShopLoadingUpdateProfileDataSuccessState) {
        return LinearProgressIndicator();
      }
      return ConditionalBuilder(
        builder: (BuildContext context) {
          return Column(
            children: [
              inputTextFormField(
                controller: usernameController,
                keyboard: TextInputType.name,
                textLabel: 'username',
                prefixIcon: Icons.person,
                onChanged: () {},
                onSubmit: () {},
                validator: (value) {
                  if (value.isEmpty) {
                    return 'username can be not empty';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 12.0,
              ),
              inputTextFormField(
                controller: emailController,
                keyboard: TextInputType.emailAddress,
                textLabel: 'E-mail',
                prefixIcon: Icons.email,
                onChanged: () {},
                onSubmit: () {},
                validator: (value) {
                  if (value.isEmpty) {
                    return 'email can be not empty';
                  }

                  return null;
                },
              ),
              inputTextFormField(
                controller: phoneController,
                keyboard: TextInputType.phone,
                textLabel: 'phone',
                prefixIcon: Icons.phone,
                onChanged: () {},
                onSubmit: () {},
                validator: (value) {
                  if (value.isEmpty) {
                    return 'phone can be not empty';
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 12.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: defaultButtonApp(
                        text: 'Login'.toUpperCase(),
                        function: () {
                          logOut(context);
                        }),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                    child: defaultButtonApp(
                        text: 'Edit Profile'.toUpperCase(),
                        function: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).shopUpdateProfileDataModel(
                              email: emailController.text,
                             // password: passwordController.text,
                              phone: phoneController.text,
                              name: usernameController.text,
                            );
                          }
                        }),
                  ),
                ],
              ),
            ],
          );
        },
        condition: true,
        fallback: (context) => CircularProgressIndicator(),
      );
    });
  }
}
