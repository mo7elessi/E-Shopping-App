import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/shared/components/components.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, ShopState? state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Search Products'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    child:CupertinoSearchTextField(
                      controller: ShopCubit.get(context).searchController,
                     // placeholder: "search product",
                      onSubmitted: (v){
                        ShopCubit.get(context).search(
                            ShopCubit.get(context).searchController.text);

                      },
                      onChanged: (v){
                         ShopCubit.get(context).search(
                            ShopCubit.get(context).searchController.text);
                      },
                    ),
                  ),
                  if (state is ShopSearchLoadingState)
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  const SizedBox(
                    height: 20.0,),
                  if (state is ShopSearchSuccessState)
                    if(state.model.data.data.length > 0)
                    Expanded(
                      child: ListView.builder(
                         // shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return buildListProduct(
                                ShopCubit.get(context)
                                    .searchModel!
                                    .data
                                    .data[index],
                                context,
                                isOldPrice: false,
                                index: index);
                          },
                          itemCount: ShopCubit.get(context)
                              .searchModel!
                              .data
                              .data
                              .length,),
                    ),
                  if (state is ShopSearchSuccessState)
                    if(state.model.data.data.length == 0)
                      Center(child: Text('Not found result about: '+ShopCubit.get(context).searchController.text)),
                ],
              ),
            ),
          );
        });
  }
}
