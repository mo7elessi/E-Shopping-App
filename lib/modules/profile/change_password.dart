import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_shopping/shared/components/components.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, ShopState state) {
      if (state is ShopChangePasswordSuccessState) {
        toastMessage(message: state.model.message, color: Colors.green);
      }
      if (state is ShopChangePasswordErrorState) {
        toastMessage(message: state.error, color: Colors.red);
      }
    }, builder: (context, ShopState state) {
      var currentPasswordController = TextEditingController();
      var newPasswordController = TextEditingController();
      var confirmPasswordController = TextEditingController();
      return Scaffold(
        appBar: AppBar(
          title: Text('Change Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              inputTextFormField(
                controller: currentPasswordController,
                keyboard: TextInputType.visiblePassword,
                textLabel: 'Current Password',
                prefixIcon: Icons.lock,
                isPassword: ShopCubit.get(context).isPassword,
                suffixIcon: ShopCubit.get(context).isPassword
                    ? Icons.visibility_off_sharp
                    : Icons.visibility_sharp,
                suffixIconPressed: () {
                  ShopCubit.get(context).changeIconSuffix();
                },
                onSubmit: (value) {},
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
                controller: newPasswordController,
                keyboard: TextInputType.visiblePassword,
                textLabel: 'New Password',
                prefixIcon: Icons.lock,
                isPassword: ShopCubit.get(context).isPassword,
                suffixIconPressed: () {
                  ShopCubit.get(context).changeIconSuffix();
                },
                onSubmit: (value) {},
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
                textLabel: 'Confirm Password',
                prefixIcon: Icons.lock,
                isPassword: ShopCubit.get(context).isPassword,
                suffixIconPressed: () {
                  ShopCubit.get(context).changeIconSuffix();
                },
                onSubmit: (value) {},
                validator: (value) {
                  if (value.isEmpty) {
                    return 'confirm password can be not empty';
                  } else if (confirmPasswordController.text !=
                      newPasswordController.text) {
                    return 'passwords not matched';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              ConditionalBuilder(
                condition: state is! ShopLoadingChangePasswordState,
                builder: (context) => defaultButtonApp(
                    text: 'Update'.toUpperCase(),
                    function: () {
                      ShopCubit.get(context).changePassword(
                          currentPassword: currentPasswordController.text,
                          newPassword: newPasswordController.text);
                    }),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      );
    });
  }
}
