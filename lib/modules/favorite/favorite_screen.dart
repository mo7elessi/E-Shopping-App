import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/shared/components/components.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/cubit/states.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (BuildContext context, ShopState state) {},
      builder: (BuildContext context, ShopState state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingFavoriteState,
          builder: (context) =>
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: ShopCubit
                      .get(context)
                      .favoritesModel!
                      .data
                      .data
                      .length > 0 ? ListView.builder(
                    itemBuilder: (context, index) {
                      // ignore: prefer_is_empty
                      if (ShopCubit
                          .get(context)
                          .favoritesModel!
                          .data
                          .data
                          .length <
                          1) {
                        return defaultScreen(
                            icon: Icons.favorite_border,
                            title: 'No Favorite Yet',
                            description: '');
                      }
                      return buildListProduct(
                          ShopCubit
                              .get(context)
                              .favoritesModel!
                              .data
                              .data[index]
                              .product,
                          context,
                          index: index);
                    },
                    itemCount:
                    ShopCubit
                        .get(context)
                        .favoritesModel!
                        .data
                        .data
                        .length,
                  ) : Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "No item in your favorite !",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Click on favorite icon to add product to favorite",
                          style: TextStyle(fontSize: 12, color: Colors.grey,),
                        ),
                      ],
                    ),
                  ),
              ),
          fallback: (context) =>
          const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
