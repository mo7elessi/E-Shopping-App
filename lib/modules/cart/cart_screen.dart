import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_shopping/layout/shop_layout.dart';
import 'package:e_shopping/modules/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/model/cart_model.dart';
import 'package:e_shopping/modules/cart/add_order_screen.dart';
import 'package:e_shopping/modules/productDetails/product_details.dart';
import 'package:e_shopping/shared/components/components.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/cubit/states.dart';
import 'package:e_shopping/shared/styles/colors.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (BuildContext context, ShopState state) {},
      builder: (BuildContext context, ShopState state) {
        var length = ShopCubit.get(context).cartModel!.data.cart_items.length;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).cartModel != null,
          builder: (context) {
            return length > 0
                ? buildCartScreen(context)
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "No item in your cart !",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Click on button shopping to add item in cart",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              defaultButtonApp(
                                  function: () {
                                    ShopCubit.get(context).onClickItemNav(0);
                                  },
                                  text: 'Shopping Now')
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildCartScreen(context) {
    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemBuilder: (context, index) => buildListCartProduct(
                ShopCubit.get(context)
                    .cartModel!
                    .data
                    .cart_items[index]
                    .product,
                context,
                index),
            itemCount: ShopCubit.get(context).cartModel!.data.cart_items.length,
          ),
        )),
        ShopCubit.get(context).cartModel!.data.cart_items.isNotEmpty
            ? buildContainerCartProduct(
                ShopCubit.get(context).cartModel!.data, context)
            : const SizedBox()
      ],
    );
  }

  Widget buildListCartProduct(
    Product model,
    context,
    index, {
    bool isOldPrice = true,
  }) {
    return GestureDetector(
      child: Card(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
          ),
          width: 100.0,
          height: 140.0,
          child: Slidable(
            actionPane: const SlidableDrawerActionPane(),
            secondaryActions: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.red,

                ),
                height:140,
                child: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.delete,size: 30,),
                    onPressed: () {
                      return  ShopCubit.get(context)
                          .addOrRemoveCart(model.id);;
                    }),
              ),
            ],
            child: Stack(
              children: [
                Row(
                  children: [
                    Image(
                      image: NetworkImage(model.image),
                      width: 100.0,
                      height: 100.0,
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              model.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12.0,
                                height: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Text(
                                model.price.toString(),
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: primaryColor,
                                ),
                              ),
                              const SizedBox(
                                width: 4.0,
                              ),
                              const Text(
                                'EGP',
                                style: TextStyle(fontSize: 10.0),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              if (model.discount != 0 && isOldPrice)
                                Text(
                                  model.oldPrice.toString(),
                                  style: const TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Text(
                                model.price.toString(),
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(
                                width: 4.0,
                              ),
                              const Text(
                                'EGP',
                                style: TextStyle(fontSize: 10.0),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  ShopCubit.get(context).QUANTITY += 1;
                                },
                                icon: const Icon(Icons.add),
                              ),
                              Text(
                                ShopCubit.get(context).QUANTITY.toString(),
                                style: const TextStyle(fontSize: 12.0),
                              ),
                              IconButton(
                                  onPressed: () {
                                    ShopCubit.get(context).QUANTITY -= 1;
                                  },
                                  icon: const Icon(Icons.remove))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(4),bottomRight: Radius.circular(4)),
                      color: Colors.red,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(model)));
      },
    );
  }

  Widget buildContainerCartProduct(Data model, context) => Card(
        elevation: 0,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
          ),
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'TOTAL',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Text(
                    '${model.total} EGP',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  const Text(
                    'SUB TOTAL',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Text(
                    '${model.sub_total} EGP',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(
                height: 28.0,
              ),
              defaultButtonApp(
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddOrderScreen()));
                  },
                  text: 'checkout')
            ],
          ),
        ),
      );
}
