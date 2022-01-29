import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/model/category_model.dart';
import 'package:e_shopping/modules/productOfCategory/product_of_category.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/cubit/states.dart';
import 'package:e_shopping/shared/styles/colors.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (BuildContext context, ShopState state) {},
        builder: (BuildContext context, state) {
          return ConditionalBuilder(
            condition: ShopCubit.get(context).categoryModel != null,
            builder: (context) => buildCategoryScreen(
                ShopCubit.get(context).categoryModel!, context),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget buildCategoryScreen(CategoryModel categoryModel, context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildCategoryItem(context, categoryModel.data.data[index]),

          itemCount: categoryModel.data.data.length,
        ),
      ),
    );
  }

  Widget buildCategoryItem(context, DataModel model) {
    return GestureDetector(
      child: Card(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                model.name.toUpperCase(),
                style: const TextStyle(
                    fontSize: 14.0,
                    color: primaryColor,
                    fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Image(
                image: NetworkImage(model.image),
                width: 60.0,
                height: 70.0,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductsOfCategory(model),
          ),
        );
      },
    );
  }
}
