import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/model/address_model.dart';
import 'package:e_shopping/modules/profile/add_edit_address.dart';
import 'package:e_shopping/shared/components/components.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/cubit/states.dart';
import 'package:e_shopping/shared/styles/colors.dart';

class AddressScreen extends StatelessWidget {
  late String city;
  late String region;
  late String details;
  late String notes;

  AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (BuildContext context, ShopState state) {
        if (state is DeleteAddressSuccessState) {
          toastMessage(message: "deleted");
        }
      },
      builder: (BuildContext context, ShopState state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).addressModel != null,
          builder: (context) =>
              buildAddressScreen(context, ShopCubit.get(context).addressModel!),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  buildAddressScreen(context, AddressModel addressModel) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddOrEditAddressScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ShopCubit.get(context).addressModel!.data.data.length > 0
            ? ListView.builder(
                shrinkWrap: false,
                itemBuilder: (context, index) => buildAddressItem(
                    ShopCubit.get(context).addressModel!.data.data[index],
                    context),
                itemCount:
                    ShopCubit.get(context).addressModel!.data.data.length,
              )
            : Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "No address yet !",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Click on + to add your address",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
            ),
      ),
    );
  }

  buildAddressItem(Data model, context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  model.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      )
                    ];
                  },
                  onSelected: (String value) {
                    if (value == "delete") {
                      ShopCubit.get(context).deleteAddress(model.id);
                    } else {}
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Divider(
              height: 1.0,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 10.0,
            ),
            itemAddress(text: 'City', info: model.city),
            const SizedBox(
              height: 10.0,
            ),
            itemAddress(text: 'Region', info: model.region),
            const SizedBox(
              height: 10.0,
            ),
            itemAddress(text: 'Details', info: model.details),
            const SizedBox(
              height: 10.0,
            ),
            itemAddress(text: 'Notes', info: model.notes),
          ],
        ),
      ),
    );
  }
}
