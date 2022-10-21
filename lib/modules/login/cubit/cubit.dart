import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

 class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(ShopLoginInitialState());
  bool isObscure=true;
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel shopLoginModel;

  void userLogin({
  @required String email,
    @required String password
}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: login,
        data: {
          'email':email,
          'password':password
        }).then((value) =>{
         shopLoginModel = ShopLoginModel.FromJson(value.data),
          emit(ShopLoginSuccessState(shopLoginModel))

    }).catchError((error){
      print(error);
      emit(ShopLoginErrorState(error));
    });
  }
  void changeObsecure(){
    isObscure=!isObscure;
    emit(ShopLoginChangeObscureState());
  }


}