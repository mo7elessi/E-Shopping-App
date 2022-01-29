class CategoryModel {
  late bool status;
  late CategoryDataModel data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoryDataModel.fromJson(json['data']);
  }
}

class CategoryDataModel {
  late int current_page;
  late List<DataModel> data=[];

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  late int id;
  late String name;
  late String image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
