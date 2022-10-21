import 'dart:convert';

class ShopLoginModel {
  bool status;
  String message;
  UserData data  ;
  ShopLoginModel.FromJson( dynamic json){
    status=json['status'];
    message=json['message'];
    data= json['data'] !=null ? UserData.FromJson(json['data']) : null;
  }
}

class UserData{
  int id;
  String name;
  String email;
  String phone;
  String image;
  int point;
  int credit;
  String token;

  UserData.FromJson(dynamic data){
    id=data['id'];
    name=data['name'];
    email=data['email'];
    phone=data['phone'];
    image=data['image'];
    point=data['point'];
    credit=data['credit'];
    token=data['token'];
  }

}