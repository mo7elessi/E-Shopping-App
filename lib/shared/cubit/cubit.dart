import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:e_shopping/model/get_orders_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shopping/model/address_model.dart';
import 'package:e_shopping/model/cart_model.dart';
import 'package:e_shopping/model/category_model.dart';
import 'package:e_shopping/model/change_cart_model.dart';
import 'package:e_shopping/model/change_favorite_model.dart';
import 'package:e_shopping/model/contact_model.dart';
import 'package:e_shopping/model/fags_model.dart';
import 'package:e_shopping/model/favorite_model.dart';
import 'package:e_shopping/model/login_model.dart';
import 'package:e_shopping/model/notification_model.dart';
import 'package:e_shopping/model/home_model.dart';
import 'package:e_shopping/model/order_model.dart';
import 'package:e_shopping/model/product_model.dart';
import 'package:e_shopping/modules/cart/cart_screen.dart';
import 'package:e_shopping/modules/categories/categories_screen.dart';
import 'package:e_shopping/modules/favorite/favorite_screen.dart';
import 'package:e_shopping/modules/home/home_screen.dart';
import 'package:e_shopping/modules/profile/profile_screen.dart';
import 'package:e_shopping/shared/components/conestance.dart';
import 'package:e_shopping/shared/cubit/states.dart';
import 'package:e_shopping/shared/network/end_points.dart';
import 'package:e_shopping/shared/network/local/cache_helper.dart';
import 'package:e_shopping/shared/network/remote/dio_helper.dart';
import 'package:e_shopping/shared/styles/colors.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);
  IconData suffixIcon = Icons.visibility_off_sharp;
  bool isPassword = true;

  void changeIconSuffix() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_off_sharp : Icons.visibility_sharp;
  }

//bottom navigation
  int currentIndex = 0;
  List<Widget> buildScreens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const CartScreen(),
    const FavoriteScreen(),
    ProfileScreen(),
  ];
  List<String> appBarTitle = [
    'Home',
    'Categories',
    'Cart',
    'Favorite',
    'Profile'
  ];
  List<BottomNavigationBarItem> navBarsItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.widgets_sharp),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: '',
    ),
  ];

  void onClickItemNav(int index) {
    currentIndex = index;
    emit(BottomNavigationState());
  }

  HomeModel? homeModel;
  Map<int, dynamic> favorites = {};
  Map<int, dynamic> carts = {};

  void getHomeData() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data.products) {
        favorites.addAll({element.id: element.inFavorites});
        carts.addAll({element.id: element.inCart});
      }
      emit(ShopHomeSuccessState());
    }).catchError((onError) {
      // print('error in home ' + onError.toString());
      emit(ShopHomeErrorState(onError.toString()));
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void addOrRemoveFavorites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(ShopChangedFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      // print(value.data);
      if (!changeFavoriteModel!.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavoriteData();
      }
      emit(ShopChangeFavoritesSuccessState(changeFavoriteModel!));
    }).catchError((onError) {
      favorites[productId] = !favorites[productId];
      emit(ShopChangeFavoritesErrorState(onError.toString()));
    });
  }

  // ignore: non_constant_identifier_names
  int QUANTITY = 1;
  ChangeCartModel? changeCartModel;

  void addOrRemoveCart(int productId) {
    carts[productId] = !carts[productId];
    emit(ShopChangedCartsState());
    DioHelper.postData(
      url: CARTS,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changeCartModel = ChangeCartModel.fromJson(value.data);
      // print(value.data);
      if (!changeCartModel!.status) {
        carts[productId] = !carts[productId];
      } else {
        getCartData();
      }
      emit(ShopChangeCartsSuccessState(changeCartModel!));
    }).catchError((onError) {
      carts[productId] = !carts[productId];
      emit(ShopChangeCartsErrorState(onError));
    });
  }

  OrderModel? orderModel;

  void addNewOrder({
    int? addressId,
    int? paymentMethod,
    bool? usePoints,
    String? promoCodeId,
  }) {
    emit(ShopAddOrderLoadingState());
    DioHelper.postData(
      url: ORDERS,
      token: token,
      data: {
        'address_id': addressId,
        'payment_method': paymentMethod,
        'use_points': usePoints,
        'promo_code_id': promoCodeId,
      },
    ).then((value) {
      orderModel = OrderModel.fromJson(value.data);
      emit(ShopAddOrderSuccessState(orderModel!));
      getOrders();
      getCartData();
      print(orderModel?.message.toString());
    }).catchError((onError) {
      emit(ShopAddOrderErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  GetOrdersModel? getOrderModel;

  void getOrders() {
    emit(ShopGetOrdersLoadingState());
    DioHelper.getData(
      url: ORDERS,
      token: token,
    ).then((value) {
      getOrderModel = GetOrdersModel.fromJson(value.data);
      print("ORDER1: ${value.data[0]}");
      emit(ShopGetOrdersSuccessState());
    }).catchError((onError) {
      emit(ShopGetOrdersErrorState(onError.toString()));
      print("ooo"+onError.toString());

    });
  }
  void getOrderDetails() {

  }

  NotificationModel? notificationModel;

  void getNotificationsData() {
    emit(ShopNotificationsLoadingState());
    DioHelper.getData(
      url: NOTIFICATIONS,
      token: token,
    ).then((value) {
      notificationModel = NotificationModel.fromJson(value.data);
      emit(ShopNotificationsSuccessState());
    }).catchError((onError) {
      emit(ShopNotificationsErrorState(onError.toString()));
    });
  }

  ProductModels? productModel;

  void getProductOfCategory(int categoryId) {
    emit(ShopLoadingGetCategoryWithProductsState());
    DioHelper.getData(url: PRODUCTS, query: {'category_id': categoryId})
        .then((value) {
      productModel = ProductModels.fromJson(value.data);
      emit(ShopGetCategoryWithProductsSuccessState(productModel!));
    }).catchError((onError) {
      emit(ShopGetCategoryWithProductsErrorState(onError));
    });
  }

  ContactModel? contactModel;

  void getContactsData() {
    emit(ShopContactsLoadingState());
    DioHelper.getData(
      url: CONTACTS,
      token: token,
    ).then((value) {
      contactModel = ContactModel.fromJson(value.data);
      // print("contact title: ${contactModel!.data.data[0].id}");
      emit(ShopContactsSuccessState());
    }).catchError((onError) {
      // print('error in contacts: ' + onError.toString());
      emit(ShopContactsErrorState(onError.toString()));
    });
  }

  CategoryModel? categoryModel;

  void getCategoriessData() {
    emit(ShopCategoriesLoadingState());
    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      // print("category title: ${categoryModel!.data.data[0].name}");
      emit(ShopCategoriesSuccessState());
    }).catchError((onError) {
      //  print('category in contacts: ' + onError.toString());
      emit(ShopCategoriesErrorState(onError.toString()));
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoriteData() {
    emit(ShopLoadingFavoriteState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      // printFullText("fav >>" + value.data.toString());
      emit(ShopFavoriteSuccessState());
    }).catchError((onError) {
      //  print('error in favorite: ' + onError.toString());
      emit(ShopFavoriteErrorState(onError.toString()));
    });
  }

  CartModel? cartModel;

  void getCartData() {
    emit(ShopLoadingCartsState());
    DioHelper.getData(
      url: CARTS,
      token: token,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      //print('???????????????? cart: ${cartModel!.data.total}');

      emit(ShopCartsSuccessState());
    }).catchError((onError) {
      // print('error in cart: ' + onError.toString());
      emit(ShopCartsErrorState(onError.toString()));
    });
  }

  LoginModel? loginModel;

  void getProfileData() {
    emit(ShopProfileLoadingLoginModelSuccessState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      //  print("username is : ${loginModel!.data.name}");
      emit(ShopLoginModelSuccessState(loginModel!));
    }).catchError((onError) {
      //  print('error in get profile data:' + onError.toString());
      emit(ShopLoginModelErrorState(onError.toString()));
    });
  }

  void shopUpdateProfileDataModel({
    String? name,
    String? phone,
    String? email,
    String? password,
  }) {
    emit(ShopLoadingUpdateProfileDataSuccessState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        //   'image': image,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      //  print("new username is : ${loginModel!.data.name}");
      emit(ShopUpdateProfileDataSuccessState(loginModel!));
    }).catchError((onError) {
      //  print('error in shop login model:' + onError.toString());
      emit(ShopUpdateProfileDataErrorState(onError.toString()));
    });
  }

  void deleteAddress(int id) {
    DioHelper.clearData(
      url: "addresses/$id",
      token: token,
    ).then((value) {
      emit(DeleteAddressSuccessState());
      getAddressData();
    }).catchError((onError) {
      emit(DeleteAddressErrorState(onError.toString()));
    });
  }

  void addNewAddress({
    String? name,
    String? city,
    String? region,
    String? details,
    String? notes,
  }) {
    emit(ShopLoadingAddressState());
    DioHelper.postData(
      url: ADDRESSES,
      token: token,
      data: {
        'name': name,
        'city': city,
        'region': region,
        'details': details,
        'latitude': '35.0616863',
        'longitude': '31.3260088',
        'notes': notes,
      },
    ).then((value) {
      emit(ShopAddAddressSuccessState(addressModel!));
      getAddressData();
    }).catchError((onError) {
      //  print("error via added:  " + onError.toString());
      emit(ShopAddAddressErrorState(onError.toString()));
    });
  }

  void changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    emit(ShopLoadingChangePasswordState());
    DioHelper.postData(
      url: CHANGE_PASSWORD,
      token: token,
      data: {
        'current_password': currentPassword,
        'new_password': newPassword,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(ShopChangePasswordSuccessState(loginModel!));
    }).catchError((onError) {
      emit(ShopChangePasswordErrorState(onError.toString()));
      //  print("errrror $onError");
    });
  }

  FaqsModel? faqsModel;

  void getFagsData() {
    DioHelper.getData(
      url: FAGS,
      token: token,
    ).then((value) {
      faqsModel = FaqsModel.fromJson(value.data);
      //  print("question 1 : ${faqsModel!.data.data[0].question}");
      emit(ShopFagsSuccessState());
    }).catchError((onError) {
      //  print('error in fags: ' + onError.toString());
      emit(ShopFagsErrorState(onError.toString()));
    });
  }

  AddressModel? addressModel;

  void getAddressData() {
    DioHelper.getData(
      url: ADDRESSES,
      token: token,
    ).then((value) {
      addressModel = AddressModel.fromJson(value.data);
      //  print("city : ${addressModel!.data.data[0].city}");
      emit(ShopAddressSuccessState(addressModel!));
    }).catchError((onError) {
      //  print('error in get address: ' + onError.toString());
      emit(ShopAddressErrorState(onError.toString()));
    });
  }

  var searchController = TextEditingController();

  ProductModels? searchModel;

  void search(String text) {
    emit(ShopSearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {'text': text},
    ).then((value) {
      searchModel = ProductModels.fromJson(value.data);
      emit(ShopSearchSuccessState(searchModel!));
    }).catchError((onError) {
      //  print('error in get search: ' + onError.toString());
      emit(ShopSearchErrorState(onError.toString()));
    });
  }
}
