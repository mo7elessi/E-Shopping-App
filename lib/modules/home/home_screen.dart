import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/model/category_model.dart';
import 'package:e_shopping/model/home_model.dart';
import 'package:e_shopping/modules/cart/cart_screen.dart';
import 'package:e_shopping/modules/productOfCategory/product_of_category.dart';
import 'package:e_shopping/modules/notifications/notification.dart';
import 'package:e_shopping/modules/search/search_screen.dart';
import 'package:e_shopping/shared/components/components.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/cubit/states.dart';
import 'package:e_shopping/shared/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (BuildContext context, ShopState state) {},
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              '.Shopping',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationsScreen(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoryModel != null,
            builder: (context) => buildHome(ShopCubit.get(context).homeModel!,
                ShopCubit.get(context).categoryModel!, context),
            fallback: (context) => Center(child: const CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildHome(HomeModel homeModel, CategoryModel categoryModel, context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // slider
          CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1.0,
              initialPage: 0,
              autoPlay: true,
              reverse: false,
              enableInfiniteScroll: true,
              autoPlayCurve: Curves.decelerate,
              scrollDirection: Axis.horizontal,
              autoPlayAnimationDuration: const Duration(seconds: 5),
            ),
            items: homeModel.data.banners
                .map(
                  (e) => Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      e.image,
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const Spacer(),
                    TextButton(
                      child: const Text(
                        'See All',
                        style: TextStyle(fontSize: 12.0, color: Colors.blue),
                      ),
                      onPressed: () {
                        ShopCubit.get(context).onClickItemNav(1);
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 4.0,
                ),
                SizedBox(
                  height: 100.0,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildCategoryItem(
                        categoryModel.data.data[index], context),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 5.0,
                    ),
                    itemCount: categoryModel.data.data.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Products',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const Spacer(),
                    TextButton(
                      child: const Text(
                        'See All',
                        style: TextStyle(fontSize: 12.0, color: Colors.blue),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                const SizedBox(
                  height: 4.0,
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  childAspectRatio: 1 / 1.25,
                  children: List.generate(
                    homeModel.data.products.length,
                    (index) => buildProductItem(
                        homeModel.data.products[index], context,
                        index: index),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryItem(DataModel model, context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductsOfCategory(model)),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: Colors.white,
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 110.0,
              height: 110.0,
              fit: BoxFit.fill,
            ),
            Container(
              width: 110.0,
              padding: const EdgeInsets.all(5.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                color: primaryColor,
              ),
              child: Text(
                model.name.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
