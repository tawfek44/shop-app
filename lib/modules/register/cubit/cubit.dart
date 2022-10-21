import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

import '../../../layout/shop_layout/cubit/shop_layout_states.dart';
import '../../../models/login_model/login_model.dart';
import '../../../shared/components/constans/constants.dart';

 class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  bool isObscure=true;
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel shopLoginModel;

  void userRegister({
  @required String name,
  @required String email,
  @required String password,
  @required String phone,
}){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: register,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        }).then((value) =>{
         shopLoginModel = ShopLoginModel.FromJson(value.data),
          emit(ShopRegisterSuccessState(shopLoginModel))

    }).catchError((error){
      emit(ShopRegisterErrorState(error));
    });
  }


  void changeObsecure(){
    isObscure=!isObscure;
    emit(ShopRegisterChangeObscureState());
  }

}