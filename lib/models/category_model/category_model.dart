class CategoriesModel {
  bool status;
  CategoryDataModel data;
  CategoriesModel.fromJson(Map <String,dynamic> json){
    status=json['status'];
    data=CategoryDataModel.fromJson(json['data']);
  }
}

class CategoryDataModel {
  List<DataModel> dataModel=[];
  CategoryDataModel.fromJson(Map <String,dynamic> json){
    for(var element in json['data']){
      DataModel _dataModel =DataModel.fromJson(element);
      dataModel.add(_dataModel);
    }
  }
}

class DataModel {
  int id;
  String name,image;
  DataModel.fromJson(Map <String,dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}