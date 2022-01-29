import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/cubit/states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (BuildContext context, ShopState state) {},
        builder: (BuildContext context, ShopState state) {
          var lengthFav =
              ShopCubit.get(context).favoritesModel?.data.data.length;
          var lengthCart =
              ShopCubit.get(context).cartModel?.data.cart_items.length;
          var index = ShopCubit.get(context).currentIndex;
          var textStyle = const TextStyle(fontSize: 14, color: Colors.white);
          return Scaffold(
            appBar: index != 0
                ? AppBar(
                    title: Text(ShopCubit.get(context)
                        .appBarTitle[ShopCubit.get(context).currentIndex]),
                    actions: [
                      if(index == 2)
                      TextButton(
                          onPressed: () {},
                          child: Text("$lengthCart Items", style: textStyle)),
                      if(index == 3)
                        TextButton(
                            onPressed: () {},
                            child: Text("$lengthFav Items", style: textStyle))
                    ],
                  )
                : null,
            body: ShopCubit.get(context)
                .buildScreens[ShopCubit.get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: ShopCubit.get(context).navBarsItems,
              currentIndex: ShopCubit.get(context).currentIndex,
              onTap: (index) {
                ShopCubit.get(context).onClickItemNav(index);
              },
            ),
          );
        });
  }
}
