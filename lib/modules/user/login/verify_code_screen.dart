import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_shopping/modules/user/login/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class VerifyCodeScreen extends StatelessWidget {
  var codeController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late String email;

  VerifyCodeScreen(this.email, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (BuildContext context, LoginStates state) {
        if (state is VerifyCodeSuccessState) {
          if (state.loginModel!.status) {
            toastMessage(message: state.loginModel!.message);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ResetPasswordScreen(email, codeController.text)));
          } else {
            toastMessage(message: state.loginModel!.message);
          }
        }
      },
      builder: (BuildContext context, LoginStates state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Verify Code'),
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
                    'Verify Code',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Text(
                    'enter the 4 digit code we send you via email adderss to continue.',
                    style: TextStyle(
                        fontSize: 14.0, height: 1.3, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  inputTextFormFieldNoIcons(
                    controller: codeController,
                    keyboard: TextInputType.emailAddress,
                    textLabel: 'Enter code here',
                    onChanged: () {},
                    onSubmit: () {},
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'code can be not empty';
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
                        text: 'Next'.toUpperCase(),
                        function: () {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).verifyCode(
                              email: email,
                              code: double.parse(codeController.text),
                            );
                          }
                        }),
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
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
