class OrderModel {
  late bool status;
  late String message;
  late Data data;

  OrderModel({required this.status, required this.message, required this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  late dynamic paymentMethod;
  late dynamic cost;
  late dynamic vat;
  late dynamic discount;
  late dynamic points;
  late dynamic total;
  late dynamic id;

  Data(
      {this.paymentMethod,
      this.cost,
      this.vat,
      this.discount,
      this.points,
      this.total,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    cost = json['cost'];
    vat = json['vat'];
    discount = json['discount'];
    points = json['points'];
    total = json['total'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method'] = this.paymentMethod;
    data['cost'] = this.cost;
    data['vat'] = this.vat;
    data['discount'] = this.discount;
    data['points'] = this.points;
    data['total'] = this.total;
    data['id'] = this.id;
    return data;
  }
}
