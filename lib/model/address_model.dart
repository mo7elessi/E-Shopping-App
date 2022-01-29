class AddressModel {
  late bool status;
  late AddressData data;

  AddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = AddressData.fromJson(json['data']);
  }
}

class AddressData {
  List<Data> data = [];

  AddressData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(Data.fromJson(element));
    });

  }
}

class Data {
  late int id;
  late String name;
  late String city;
  late String region;
  late String details;
  late dynamic latitude;
  late dynamic longitude;
  late String notes;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    details = json['details'];
    region = json['region'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    notes = json['notes'];
  }
}
