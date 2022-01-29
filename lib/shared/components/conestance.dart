import 'package:e_shopping/modules/user/login/tabs.dart';
import 'package:flutter/material.dart';
import 'package:e_shopping/shared/network/local/cache_helper.dart';

void logOut(context){
  CacheHelper.clearData(key: 'token').then((value) {
    if (value) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const Tabs(),
        ),
            (route) {
          return false;
        },
      );
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token ='';