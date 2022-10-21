import 'package:flutter/cupertino.dart';

class HomeModel{
  bool status;
  String message;
  HomeModelData data;
  HomeModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data= HomeModelData.fromJson(json['data']);
}
}

class HomeModelData{
  List<Banner>banners=[];
  List<Product>products=[];
  HomeModelData.fromJson(Map<String,dynamic>json){
    for(var element in json['banners']){
      Banner b = Banner.fromJson(element);
      banners.add(b);
    }
    for(var element in json['products']){
      Product b = Product.fromJson(element);
      products.add(b);
    }
  }
}

class Banner{
  int id;
  String image;
  dynamic category,product;
  Banner.fromJson(Map<String,dynamic>json){
    id=json['id'];
    image=json['image'];
    category=json['category'];
    product=json['product'];
  }
}
class Product{
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic dicount;
  String image;
  String name;
  bool inFavourite;
  bool inCart;
  Product.fromJson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    dicount=json['dicount'];
    image=json['image'];
    name=json['name'];
    inFavourite=json['in_favourite'];
    inCart=json['in_cart'];
  }
}