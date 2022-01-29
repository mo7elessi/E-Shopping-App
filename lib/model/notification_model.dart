class NotificationModel {
  late bool status;
  late NotificationData data;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = NotificationData.fromJson(json['data']);
  }
}

class NotificationData {
  late int current_page;
  late List<Data> data = [];

  NotificationData.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data.add(Data.fromJson(element));
    });
  }
}

class Data {
  late int id;
  late String title;
  late String message;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
  }
}
