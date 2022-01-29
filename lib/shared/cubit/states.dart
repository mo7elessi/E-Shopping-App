import 'package:e_shopping/model/address_model.dart';
import 'package:e_shopping/model/change_cart_model.dart';
import 'package:e_shopping/model/change_favorite_model.dart';
import 'package:e_shopping/model/login_model.dart';
import 'package:e_shopping/model/order_model.dart';
import 'package:e_shopping/model/product_model.dart';

abstract class ShopState {}

class ShopInitialStates extends ShopState {}

class BottomNavigationState extends ShopState {}

class ChangeIconFavoriteState extends ShopState {}

class LoginLoadingState extends ShopState {}

// home state
class ShopHomeLoadingState extends ShopState {}

class ShopHomeSuccessState extends ShopState {
  final ShopState? homeModel;

  ShopHomeSuccessState({this.homeModel});
}

class ShopGetProductSuccessState extends ShopState {}

class ShopGetProductErrorState extends ShopState {
  final String error;

  ShopGetProductErrorState(this.error);
}

class ShopHomeErrorState extends ShopState {
  final String error;

  ShopHomeErrorState(this.error);
}

// Categories state
class ShopCategoriesLoadingState extends ShopState {}

class ShopCategoriesSuccessState extends ShopState {
  final ShopState? categortModel;

  ShopCategoriesSuccessState({this.categortModel});
}

class ShopCategoriesErrorState extends ShopState {
  final String error;

  ShopCategoriesErrorState(this.error);
}

// notifications state
class ShopNotificationsLoadingState extends ShopState {}

class ShopNotificationsSuccessState extends ShopState {
  final ShopState? notificationModel;

  ShopNotificationsSuccessState({this.notificationModel});
}

class ShopNotificationsErrorState extends ShopState {
  final String error;

  ShopNotificationsErrorState(this.error);
}

class ShopGetOrdersLoadingState extends ShopState {}

class ShopGetOrdersSuccessState extends ShopState {
  final ShopState? notificationModel;

  ShopGetOrdersSuccessState({this.notificationModel});
}

class ShopGetOrdersErrorState extends ShopState {
  final String error;

  ShopGetOrdersErrorState(this.error);
}

// contact state
class ShopContactsLoadingState extends ShopState {}

class ShopContactsSuccessState extends ShopState {
  final ShopState? contactModel;

  ShopContactsSuccessState({this.contactModel});
}

class ShopContactsErrorState extends ShopState {
  final String error;

  ShopContactsErrorState(this.error);
}

class ShopChangeFavoritesSuccessState extends ShopState {
  final ChangeFavoriteModel model;

  ShopChangeFavoritesSuccessState(this.model);
}

class ShopChangedFavoritesState extends ShopState {}

class ShopChangeFavoritesErrorState extends ShopState {
  final String error;

  ShopChangeFavoritesErrorState(this.error);
}

class ShopLoadingFavoriteState extends ShopState {}

class ShopFavoriteSuccessState extends ShopState {}

class ShopFavoriteErrorState extends ShopState {
  final String error;

  ShopFavoriteErrorState(this.error);
}

class ShopChangeCartsSuccessState extends ShopState {
  final ChangeCartModel model;

  ShopChangeCartsSuccessState(this.model);
}

class ShopChangedCartsState extends ShopState {}

class ShopChangeCartsErrorState extends ShopState {
  final String error;

  ShopChangeCartsErrorState(this.error);
}

class ShopLoadingCartsState extends ShopState {}

class ShopCartsSuccessState extends ShopState {}

class ShopCartsErrorState extends ShopState {
  final String error;

  ShopCartsErrorState(this.error);
}

class ShopLoginModelSuccessState extends ShopState {
  final LoginModel model;

  ShopLoginModelSuccessState(this.model);
}

class ShopProfileLoadingLoginModelSuccessState extends ShopState {}

class ShopLoginModelErrorState extends ShopState {
  final String error;

  ShopLoginModelErrorState(this.error);
}

class ShopLoadingUpdateProfileDataSuccessState extends ShopState {}

class ShopUpdateProfileDataSuccessState extends ShopState {
  final LoginModel model;

  ShopUpdateProfileDataSuccessState(this.model);
}

class ShopUpdateProfileDataErrorState extends ShopState {
  final String error;

  ShopUpdateProfileDataErrorState(this.error);
}

class ShopLoadingAddressState extends ShopState {}

class ShopAddressSuccessState extends ShopState {
  final AddressModel model;

  ShopAddressSuccessState(this.model);
}

class ShopAddressErrorState extends ShopState {
  final String error;

  ShopAddressErrorState(this.error);
}

class ShopAddLoadingAddressState extends ShopState {}

class ShopAddAddressSuccessState extends ShopState {
  final AddressModel model;

  ShopAddAddressSuccessState(this.model);
}

class ShopAddAddressErrorState extends ShopState {
  final String error;

  ShopAddAddressErrorState(this.error);
}

class DeleteAddressSuccessState extends ShopState {}

class DeleteAddressErrorState extends ShopState {
  final String error;

  DeleteAddressErrorState(this.error);
}

class ShopLoadingChangePasswordState extends ShopState {}

class ShopChangePasswordSuccessState extends ShopState {
  final LoginModel model;

  ShopChangePasswordSuccessState(this.model);
}

class ShopChangePasswordErrorState extends ShopState {
  final String error;

  ShopChangePasswordErrorState(this.error);
}

class ShopLoadingGetCategoryWithProductsState extends ShopState {}

class ShopGetCategoryWithProductsSuccessState extends ShopState {
  final ProductModels model;

  ShopGetCategoryWithProductsSuccessState(this.model);
}

class ShopGetCategoryWithProductsErrorState extends ShopState {
  final String error;

  ShopGetCategoryWithProductsErrorState(this.error);
}

class ShopFagsSuccessState extends ShopState {
  final ShopState? fagModel;

  ShopFagsSuccessState({this.fagModel});
}

class ShopFagsErrorState extends ShopState {
  final String error;

  ShopFagsErrorState(this.error);
}

class ShopSearchLoadingState extends ShopState {}

class ShopSearchSuccessState extends ShopState {
  final ProductModels model;

  ShopSearchSuccessState(this.model);
}

class ShopSearchErrorState extends ShopState {
  final String error;

  ShopSearchErrorState(this.error);
}

class ShopAddOrderLoadingState extends ShopState {}

class ShopAddOrderSuccessState extends ShopState {
  final OrderModel model;

  ShopAddOrderSuccessState(this.model);
}

class ShopAddOrderErrorState extends ShopState {
  final String error;

  ShopAddOrderErrorState(this.error);
}
