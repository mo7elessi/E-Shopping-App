import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_shopping/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/cubit/states.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (BuildContext context, ShopState state) {},
      builder: (BuildContext context, ShopState state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Order History'),
          ),
          body: ConditionalBuilder(
            condition: ShopCubit.get(context).getOrderModel != null,
            builder: (BuildContext context) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return buildOrderItems(
                      context: context,
                      model: ShopCubit.get(context)
                          .getOrderModel!
                          .data!
                          .data![index]);

                },
                itemCount:
                    ShopCubit.get(context).getOrderModel!.data!.data!.length,
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
