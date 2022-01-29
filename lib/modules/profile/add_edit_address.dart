// ignore: file_names
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/shared/components/components.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/cubit/states.dart';

class AddOrEditAddressScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, ShopState? state) {
          var formKey = GlobalKey<FormState>();
          var nameAddressController = TextEditingController();
          var cityAddressController = TextEditingController();
          var regionAddressController = TextEditingController();
          var detailsAddressController = TextEditingController();
          var notesAddressController = TextEditingController();
          if (state is ShopAddAddressSuccessState) {
            if (state.model.status) {
              toastMessage(message: 'added successfully');
              Navigator.pop(context);
            } else {
              toastMessage(message: 'added field');
            }
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Add New Address'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    inputTextFormFieldNoIcons(
                      controller: nameAddressController,
                      keyboard: TextInputType.text,
                      textLabel: 'Name Address',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'name can be not empty';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    inputTextFormFieldNoIcons(
                      controller: cityAddressController,
                      keyboard: TextInputType.text,
                      textLabel: 'City',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'city can be not empty';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    inputTextFormFieldNoIcons(
                      controller: regionAddressController,
                      keyboard: TextInputType.text,
                      textLabel: 'Region',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'region can be not empty';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    inputTextFormFieldNoIcons(
                      controller: detailsAddressController,
                      keyboard: TextInputType.text,
                      textLabel: 'Details',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'details can be not empty';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    inputTextFormFieldNoIcons(
                      controller: notesAddressController,
                      keyboard: TextInputType.text,
                      textLabel: 'Notes',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'notes can be not empty';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    ConditionalBuilder(
                      condition: state is! ShopLoadingAddressState,
                      builder: (context) => defaultButtonApp(
                          text: 'Add'.toUpperCase(),
                          function: () {
                           if(formKey.currentState!.validate()) {
                              ShopCubit.get(context).addNewAddress(
                                city: cityAddressController.text,
                                details: detailsAddressController.text,
                                name: nameAddressController.text,
                                notes: notesAddressController.text,
                                region: regionAddressController.text,
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
        });
  }
}
