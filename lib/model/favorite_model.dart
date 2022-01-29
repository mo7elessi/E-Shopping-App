class FavoritesModel {
  late bool status;
  late String message;
  late Data data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }
}

class Data {
  late int currentPage;
  List<ItemFavoritesData> data = [];
  late int to;
  late int total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new ItemFavoritesData.fromJson(v));
      });
    }
    to = json['to'];
    total = json['total'];
  }
}

class ItemFavoritesData {
  late int id;
  late Product product;

  ItemFavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = (json['product'] != null
        ? new Product.fromJson(json['product'])
        : null)!;
  }
}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;
  //late List<String> images;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
   // images = json['images'].cast<String>();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    //data['images'] = this.images;

    return data;
  }
}
