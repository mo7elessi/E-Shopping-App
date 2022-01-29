import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_shopping/modules/user/login/verify_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class VerifyEmailScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (BuildContext context, LoginStates state) {
        if (state is VerifyEmailSuccessState) {
          if (state.loginModel!.status) {
            toastMessage(message: state.loginModel!.message);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        VerifyCodeScreen(emailController.text)));
          }else {
            toastMessage(message: state.loginModel!.message);
          }
        }
      }, builder: (BuildContext context, LoginStates state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Verify Email'),
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
                    'Verify Email',
                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color:Colors.black54),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Text(
                    'please enter your email to receive a code to create a new password via email.',
                    style: TextStyle(fontSize: 14.0, height: 1.3,color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 20.0,
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
                  const SizedBox(
                    height: 12.0,
                  ),
                  ConditionalBuilder(
                    condition: state is! VerifyEmailLoadingState,
                    builder: (context) => defaultButtonApp(
                        text: 'Send'.toUpperCase(),
                        function: () {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).verifyEmail(
                              email: emailController.text,
                            );
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
      }),
    );
  }
}
