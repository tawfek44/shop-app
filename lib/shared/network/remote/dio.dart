import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper{
  static Dio dio;
  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      )
    );
  }

  static Future<Response> postData ({
  @required String url,
  @required Map<String,dynamic> data,
    String token
  }){
    dio.options.headers={
      'Content-Type':'application/json',
      'lang':'en',
      'Authorization':token,
    };
    return dio.post(
      url,
      data: data
    );
  }
  static Future<Response> putData ({
    @required String url,
    @required Map<String,dynamic> data,
    String token
  }){
    dio.options.headers={
      'Content-Type':'application/json',
      'lang':'en',
      'Authorization':token,
    };
    return dio.put(
        url,
        data: data
    );
  }
  static Future<Response> getData ({
    @required String url,
    Map<String,dynamic>query,
    String token
  }){
    dio.options.headers={
      'Content-Type':'application/json',
      'Authorization':token,
      'lang':'en',
    };
    return dio.get(
        url,
      queryParameters: query
    );
  }
}