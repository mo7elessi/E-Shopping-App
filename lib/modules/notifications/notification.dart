import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/model/notification_model.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/cubit/states.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (BuildContext context, ShopState state) {},
      builder: (BuildContext context, ShopState state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Notifications'),
          ),
          body: ConditionalBuilder(
            condition: ShopCubit.get(context).notificationModel != null,
            builder: (BuildContext context) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return buildNotificationItem(
                      context,
                      ShopCubit.get(context)
                          .notificationModel!
                          .data
                          .data[index]);
                },

                itemCount:
                    ShopCubit.get(context).notificationModel!.data.data.length,
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildNotificationItem(context, Data model) {
    return Card(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title,
                style: const TextStyle(fontSize: 16.0, color: Colors.black),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                model.message,
                style: const TextStyle(fontSize: 12.0, color: Colors.grey,height: 1.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
