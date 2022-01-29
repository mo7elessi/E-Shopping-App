class ContactModel {
  late bool status;
  late ContactDataModel data;

  ContactModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = ContactDataModel.fromJson(json['data']);
  }
}

class ContactDataModel {
  late int current_page;
  late List<DataModel> data=[];

  ContactDataModel.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  late int id;
  late int type;
  late String value;
  late String image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    value = json['value'];
    image = json['image'];
  }
}
