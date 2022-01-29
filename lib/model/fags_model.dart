class FaqsModel{
  late bool status;
  late FaqsData data;
  FaqsModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = FaqsData.fromJson(json['data']);
  }
}
class FaqsData{
  List<Data> data =[];
  FaqsData.fromJson(Map<String,dynamic> json){
    json['data'].forEach((element) {
      data.add(Data.fromJson(element));
    });
  }
}
class Data{
  late int id;
  late String question;
  late String answer;
  Data.fromJson(Map<String,dynamic> json){
    id = json['id'];
    question= json['question'];
    answer= json['answer'];
  }
}