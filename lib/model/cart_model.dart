class CartModel {
  late bool status;
  late String message;
  late Data data;

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }
}

class Data {
  List<ItemCartData> cart_items = [];
  late dynamic sub_total;
  late dynamic total;

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    sub_total = json['sub_total'];

    json['cart_items'].forEach((element) {
      cart_items.add(ItemCartData.fromJson(element));
    });
  }
}

class ItemCartData {
  late int id;
  late dynamic quantity;
  late Product product;

  ItemCartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = (json['product'] != null? new Product.fromJson(json['product']): null)!;
  }
}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;
  late List<String> images;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['images'] = this.images;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}
