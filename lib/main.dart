import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/layout/shop_layout.dart';
import 'package:e_shopping/modules/onBoarding/on_boarding_screen.dart';
import 'package:e_shopping/shared/components/conestance.dart';
import 'package:e_shopping/shared/cubit/bloc_observe.dart';
import 'package:e_shopping/shared/cubit/cubit.dart';
import 'package:e_shopping/shared/cubit/states.dart';
import 'package:e_shopping/shared/network/local/cache_helper.dart';
import 'package:e_shopping/shared/network/remote/dio_helper.dart';
import 'package:e_shopping/shared/styles/themes.dart';
import 'modules/user/login/cubit/cubit.dart';
import 'modules/user/login/tabs.dart';
import 'modules/user/register/cubit/cubit.dart';

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');
  bool changeIcon = CacheHelper.getData(key: 'grid');

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else
      widget = Tabs();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
    changeIcon: changeIcon,
  ));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget {
  // constructor
  // build
  final bool isDark;
  final Widget startWidget;
  final bool changeIcon;

  MyApp({
    required this.isDark,
    required this.changeIcon,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getHomeData()
              ..getContactsData()
              ..getNotificationsData()
              ..getAddressData()
              ..getFavoriteData()
              ..getCategoriessData()
              ..getProfileData()
              ..getFagsData()
              ..getOrders()
              ..getCartData()),
        BlocProvider(create: (BuildContext context) => LoginCubit()),
        BlocProvider(
          create: (BuildContext context) => RegisterCubit(),
        )
      ],
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeLight,
            home: startWidget,
            // home: ShopLayout(),
          );
        },
      ),
    );
  }
}
