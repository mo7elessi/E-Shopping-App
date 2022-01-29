import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_shopping/modules/profile/add_edit_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/model/address_model.dart';
import 'package:e_shopping/shared/components/components.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/cubit/states.dart';

class AddOrderScreen extends StatelessWidget {
  int addressId = 1;
  int paymentMethod = 1;
  bool points = false;

  AddOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (BuildContext context, ShopState? state) {
        if (state is ShopAddOrderSuccessState) {
          toastMessage(message: state.model.message);
        }
      },
      builder: (BuildContext context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('New Order'),
        ),
        body: buildOrderScreen(context, state),
      ),
    );
  }

  Widget buildOrderScreen(context, state) {
    var promoCode = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          selectPaymentMethod(),
          const SizedBox(height: 20.0),
          const Text(
            'Select Current Address:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10.0),
          if (ShopCubit.get(context).addressModel!.data.data.length < 1)
            Row(
              children: [
                const Text(
                  'No address yet:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddOrEditAddressScreen()));
                  },
                  child: const Text(
                    'Add Address',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
          const SizedBox(height: 10.0),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => selectAddress(
                ShopCubit.get(context).addressModel!.data.data[index], context),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10.0,
            ),
            itemCount: ShopCubit.get(context).addressModel!.data.data.length,
          ),
          const SizedBox(height: 20.0),
          const Text(
            'Enter Promo Code (Optional):',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10.0),
          inputTextFormFieldNoIcons(
              controller: promoCode,
              keyboard: TextInputType.text,
              validator: () {},
              textLabel: ''),
          const SizedBox(height: 20.0),
          /*ConditionalBuilder(
              condition: state is ShopAddOrderLoadingState,
              fallback: (context) => const CircularProgressIndicator(),
              builder: (BuildContext context) {
                return
              })*/
          defaultButtonApp(
              function: () {
                ShopCubit.get(context).addNewOrder(
                  addressId: addressId,
                  paymentMethod: paymentMethod,
                  promoCodeId: promoCode.text,
                  usePoints: false,
                );
              },
              text: 'Checkout'),
        ],
      ),
    );
  }

  Widget selectPaymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Payment Method:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 10.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  paymentMethod = 1;
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("PayPal"),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              GestureDetector(
                onTap: () {
                  paymentMethod = 2;
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("Master Card"),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              GestureDetector(
                onTap: () {
                  paymentMethod = 3;
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("Cash"),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              GestureDetector(
                onTap: () {
                  paymentMethod = 3;
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("Pioneer"),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget selectAddress(Data model, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            addressId = model.id;
          },
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                model.name,
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
