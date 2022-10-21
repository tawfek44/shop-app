class SearchModel {
  bool status;
  ParseProductData model;
  SearchModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    model = ParseProductData.fromJson(json['data']);
  }
}

class ParseProductData {
  List<DataFav>lst=[];
  ParseProductData.fromJson(Map<String,dynamic>json){
    for(var element in json['data']){
      DataFav d =DataFav.fromJson(element);
      lst.add(d);
    }
  }
}

class DataFav {
  int id;
  dynamic price,oldPrice,discount;
  String image,name,description;

  DataFav.fromJson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];

  }
}