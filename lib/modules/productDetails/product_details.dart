import 'package:conditional_builder/conditional_builder.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:e_shopping/shared/components/components.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/cubit/states.dart';
import 'package:e_shopping/shared/styles/colors.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatelessWidget {
  dynamic model;
  ProductDetailsScreen(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, ShopState state) {},
        builder: (context, ShopState state) {
          PageController productImages = PageController();
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.black87)),
                    ConditionalBuilder(
                      condition: model != null,
                      builder: (context) => SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 300.0,
                              width: 300.0,
                              child: PageView.builder(
                                controller: productImages,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) => Image(
                                  image:
                                      NetworkImage('${model.images![index]}'),
                                  height: 300.0,
                                  width: 300.0,
                                ),
                                itemCount: model.images!.length,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          ShopCubit.get(context)
                                              .addOrRemoveFavorites(model.id);
                                        },
                                        icon: Icon(
                                          ShopCubit.get(context)
                                                  .favorites[model.id]
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: ShopCubit.get(context)
                                                  .favorites[model.id]
                                              ? primaryColor
                                              : Colors.grey,
                                          size: 30.0,
                                        ),
                                      ),
                                      Spacer(),
                                      SmoothPageIndicator(
                                        controller: productImages,
                                        count: model.images!.length,
                                        effect: const ExpandingDotsEffect(
                                            dotColor: Color(0xffeaeaea),
                                            activeDotColor: primaryColor,
                                            expansionFactor: 2,
                                            dotHeight: 8,
                                            dotWidth: 12,
                                            spacing: 5),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  Text(
                                    model.name,
                                    style: const TextStyle(
                                        fontSize: 14, height: 1.4),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    children: [
                                      const Text('Price',
                                          style: TextStyle(fontSize: 14.0)),
                                      const Spacer(),
                                      Text(
                                        '${model.price} EGP',
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            color: primaryColor),
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      if (model.oldPrice != null)
                                        Text(
                                          '${model.oldPrice} EGP',
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  ExpandablePanel(
                                    theme: const ExpandableThemeData(
                                      headerAlignment:
                                          ExpandablePanelHeaderAlignment.center,
                                      tapBodyToCollapse: true,
                                    ),
                                    header: const Text('Information Details',
                                        style: TextStyle(fontSize: 14.0)),
                                    collapsed: const Text(''),
                                    expanded: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text('${model.description}',
                                          style: const TextStyle(
                                              height: 1.3, color: Colors.grey)),
                                    ),
                                    builder: (_, collapsed, expanded) {
                                      return Expandable(
                                        collapsed: collapsed,
                                        expanded: expanded,
                                        theme: const ExpandableThemeData(
                                            crossFadePoint: 0),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  Row(
                                    children: [
                                      const Text('Quantity',
                                          style: TextStyle(fontSize: 14.0)),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            ShopCubit.get(context).QUANTITY +=
                                                1;
                                          },
                                          icon: const Icon(Icons.add),
                                          iconSize: 30.0,
                                          color: primaryColor),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${ShopCubit.get(context).QUANTITY}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          ShopCubit.get(context).QUANTITY -= 1;
                                        },
                                        icon: const Icon(Icons.remove),
                                        iconSize: 30.0,
                                        color: primaryColor,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 50.0,
                                  ),
                                  defaultButtonApp(
                                      textColor:
                                          ShopCubit.get(context).carts[model.id]
                                              ? primaryColor
                                              : Colors.white,
                                      text:
                                          ShopCubit.get(context).carts[model.id]
                                              ? 'Cancel'
                                              : 'Add to cart',
                                      background:
                                          ShopCubit.get(context).carts[model.id]
                                              ? Colors.blue.shade50
                                              : primaryColor,
                                      isUppercase: true,
                                      function: () {
                                        ShopCubit.get(context)
                                            .addOrRemoveCart(model.id);
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
