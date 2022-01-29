class LoginModel {
  late bool status;
  late String message;
  late UserData data;

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null!;
  }
}

class UserData {
  late dynamic id;
  late String name;
  late String phone;
  late String email;
  late String image;
  late dynamic points;
  late dynamic credit;
  late String token;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
