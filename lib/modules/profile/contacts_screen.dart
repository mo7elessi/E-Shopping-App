import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/model/contact_model.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/cubit/states.dart';
class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ContactModel? contactModel;
    return BlocProvider(
      create: (context) => ShopCubit()..getContactsData(),
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (BuildContext context, ShopState state) {},
        builder: (BuildContext context, ShopState state) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            itemBuilder: (context, index) => buildContactItem(
              contactModel!.data.data[index],
            ),
            itemCount: contactModel!.data.data.length,
          ),
        ),
      ),
    );
  }

  Widget buildContactItem(DataModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: Image.network(
            '${model.image}',
            width: 100.0,
            height: 100.0,
          ),
          onTap: () {
         /*  String url = '${model.value}';
           html.window.open(url, 'name');*/
          },
        ),
      ],
    );
  }

  void onOpen() {}
}
