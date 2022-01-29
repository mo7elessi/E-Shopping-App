import 'package:conditional_builder/conditional_builder.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/model/fags_model.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/cubit/states.dart';

class FagsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (BuildContext context, ShopState state) {},
      builder: (BuildContext context, ShopState state) => Scaffold(
        appBar: AppBar(title: const Text('Question & Answer')),
        body: ConditionalBuilder(
          condition: ShopCubit.get(context).faqsModel != null,
          builder: (context) =>
              buildFagsScreen(context, ShopCubit.get(context).faqsModel!),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  buildFagsScreen(context, FaqsModel model) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
          itemBuilder: (context, index) =>
              buildFagsItem(context, model.data.data[index]),
          itemCount: model.data.data.length),
    );
  }

  Widget buildFagsItem(context, Data model) {
    return ExpandableNotifier(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: false,
              scrollOnCollapse: false,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Text(
                    model.question,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  collapsed: const SizedBox(
                    height: 5,
                  ),
                  expanded: Text(
                    model.answer,
                    style:
                        const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  builder: (_, collapsed, expanded) {
                    return Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
