import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_shopping/shared/components/components.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfile extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  EditProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, ShopState state) {
      if (state is ShopUpdateProfileDataSuccessState) {
        toastMessage(message: state.model.message, color: Colors.green);
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      var usernameController = TextEditingController();
      var emailController = TextEditingController();
      var phoneController = TextEditingController();
      String image = '';
      if (ShopCubit.get(context).loginModel == null) {
        const Center(child: CircularProgressIndicator());
      } else {
        var user = ShopCubit.get(context).loginModel;
        usernameController.text = user!.data.name;
        emailController.text = user.data.email;
        phoneController.text = user.data.phone;
        image = user.data.image;
      //  print('usernameController: ${user.data.name.toString()}');
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20.0,
                ),

                if (image != null)
                  CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(image),
                  ),
                if (image == null)
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.cloud_upload),
                    iconSize: 30.0,
                  ),
                const SizedBox(
                  height: 48.0,
                ),
                inputTextFormField(
                  controller: usernameController,
                  keyboard: TextInputType.text,
                  textLabel: 'Username',
                  prefixIcon: Icons.person,
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
                  controller: phoneController,
                  keyboard: TextInputType.phone,
                  textLabel: 'Phone',
                  prefixIcon: Icons.phone,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'phone can be not empty';
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 24.0,
                ),
                ConditionalBuilder(
                  condition: state is! ShopLoadingUpdateProfileDataSuccessState,
                  builder: (context) => defaultButtonApp(
                      text: 'Update'.toUpperCase(),
                      function: () {
                       if (formKey.currentState!.validate()) {
                        ShopCubit.get(context).shopUpdateProfileDataModel(
                            email: emailController.text,
                            name: usernameController.text,
                            phone: phoneController.text);
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
    });
  }
}
