import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/modules/search/search_screen.dart';
import 'package:e_shopping/shared/components/components.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/cubit/states.dart';

class ProductsOfCategory extends StatefulWidget {
  dynamic model;
  ProductsOfCategory(this.model, {Key? key}) : super(key: key);

  @override
  State<ProductsOfCategory> createState() => _ProductsOfCategoryState();
}


class _ProductsOfCategoryState extends State<ProductsOfCategory> {
  @override
  void initState() {
    ShopCubit.get(context).productModel?.data.data = [];
    ShopCubit.get(context).getProductOfCategory(widget.model.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, ShopState state) {},
      builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(widget.model.name),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.search),
                color: Colors.white,
              ),
            ],
          ),
          body: ConditionalBuilder(
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
              condition: ShopCubit.get(context).productModel != null,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        //if(id != null)
                        GridView.count(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          childAspectRatio: 1 / 1.25,
                          children: List.generate(
                            ShopCubit.get(context)
                                .productModel!
                                .data
                                .data
                                .length,
                            (index) => buildProductItem(
                                ShopCubit.get(context)
                                    .productModel!
                                    .data
                                    .data[index],
                                context,
                                index: index),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
