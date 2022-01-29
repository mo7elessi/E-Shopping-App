import 'package:e_shopping/modules/profile/order_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_shopping/modules/profile/change_password.dart';
import 'package:e_shopping/modules/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_shopping/modules/profile/address.dart';
import 'package:e_shopping/modules/profile/contacts_screen.dart';
import 'package:e_shopping/modules/profile/fags_screen.dart';
import 'package:e_shopping/modules/settings/settings.dart';
import 'package:e_shopping/shared/components/components.dart';
import 'package:e_shopping/shared/components/conestance.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/cubit/states.dart';

class ProfileScreen extends StatelessWidget {
  String username = '';
  String email = '';
  String image = '';

  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (BuildContext context, ShopState state) {
      if (ShopCubit.get(context).loginModel == null) {
        const CircularProgressIndicator();
      } else {}
    }, builder: (BuildContext context, ShopState state) {
      var user = ShopCubit.get(context).loginModel;
      username = user!.data.name;
      email = user.data.email;
      image = user.data.image;
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage('$image'),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                username,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                email,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              buildProfileItems(
                  icon: Icons.history,
                  text: 'Order History',
                  context: context,
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderHistory(),
                      ),
                    );
                  }),
              buildProfileItems(
                  icon: Icons.location_on,
                  text: 'Address',
                  context: context,
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddressScreen(),
                      ),
                    );
                  }),
              buildProfileItems(
                  icon: Icons.lock,
                  text: 'Change Password',
                  context: context,
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen(),
                      ),
                    );
                  }),
              buildProfileItems(
                  icon: Icons.edit,
                  text: 'Edit Profile',
                  context: context,
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfile(),
                      ),
                    );
                  }),
              buildProfileItems(
                  icon: Icons.settings,
                  text: 'Settings',
                  context: context,
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsScreen(),
                      ),
                    );
                  }),
              buildProfileItems(
                  icon: Icons.contact_support_rounded,
                  text: 'Question & Answer',
                  context: context,
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FagsScreen(),
                      ),
                    );
                  }),
              buildProfileItems(
                  icon: Icons.message,
                  text: 'Contacts',
                  context: context,
                  function: () {
                    /* Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactScreen(),
                      ),
                    );*/
                    Dialog(
                      child: Container(
                        height: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FlutterLogo(
                              size: 150,
                            ),
                            Text(
                              "This is a Custom Dialog",
                              style: TextStyle(fontSize: 20),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Close"))
                          ],
                        ),
                      ),
                    );
                  }),
              buildProfileItems(
                  icon: Icons.logout,
                  text: 'Logout',
                  isNewScreen: false,
                  context: context,
                  function: () {
                    showAlertDialog(context);
                  }),
            ],
          ),
        ),
      );
    });
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("Yes"),
    onPressed: () {
      logOut(context);
    },
  );
  Widget cancelButton = TextButton(
    child: const Text("No"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Logout"),
    content: const Text(
      "Are you sure you want to logout of the application?",
      style: TextStyle(
        fontSize: 14,
        color: Colors.black54,
      ),
    ),
    actions: [
      cancelButton,
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
