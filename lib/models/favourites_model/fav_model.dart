class FavouritesModel {
  bool status;
  FavouritesDataModel model;
  FavouritesModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    model=FavouritesDataModel.fromJson(json['data']);
  }
}

class FavouritesDataModel {
  List<DataFav> dataModelList =[];
  Map<int,bool>fav={};
  FavouritesDataModel.fromJson(Map<String,dynamic>json){
    for(var element in json['data']){
      DataFav _dd =DataFav.fromJson(element);
      dataModelList.add(_dd);
      fav.addAll({
        _dd.id:true
      });
    }
  }
}

class DataFav {
  int id;
  dynamic price,oldPrice,discount;
  String image,name,description;

  DataFav.fromJson(Map<String,dynamic>json){
    id=json['product']['id'];
    price=json['product']['price'];
    oldPrice=json['product']['old_price'];
    discount=json['product']['discount'];
    image=json['product']['image'];
    name=json['product']['name'];
    description=json['product']['description'];

  }
}