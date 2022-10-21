import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_layout_states.dart';
import 'package:shop_app/models/favourites_model/add_or_delete_fav.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/components/components.dart';
import 'package:shop_app/shared/components/constans/constants.dart';
import 'package:shop_app/shared/network/remote/dio.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

import '../../../models/category_model/category_model.dart';
import '../../../models/favourites_model/fav_model.dart';
import '../../../modules/favourite/favourite_screen.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates>{
  ShopLayoutCubit() : super(ShopLayoutInitialState());
  static ShopLayoutCubit get(context) => BlocProvider.of(context);
  Map<int , bool> favourite={};
  int currentIndex=0;
  List<Widget> bottomNavScreens = const [
    ProductScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingsScreen()
  ];
  void changeBottom(int idx){
    currentIndex=idx;
    emit(ShopChangeBottomNavBarState());
  }
  HomeModel homeModel;
  void getHomeData(){
      emit(ShopLoadingDataState());
      DioHelper.getData(url: home,token: token).then((value) {
      homeModel=HomeModel.fromJson(value.data);
      emit(ShopSuccessDataState());
    }).catchError((error){
      emit(ShopErrorDataState());
    });
  }

  CategoriesModel categoriesModel;
  void getCategoriesData(){
    DioHelper.getData(url: categories,token: token)
        .then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      emit(ShopErrorCategoriesState());
    });
  }

  FavouritesModel favModel ;
  void getFavourites()
  {
    DioHelper.getData(
      url: favourites,
      token: token
    ).then((value) {
      favModel=FavouritesModel.fromJson(value.data);
      favourite=favModel.model.fav;
      emit(ShopSuccessFavouritesState());
    }).catchError((error){
      emit(ShopErrorFavouritesState());
    });
  }
  ChangeFavModel changeFavModel;
  void changeFav(int productID){
    emit(ShopChangeFavouritesState());
    DioHelper.postData(
        url: favourites,
        data:{
          'product_id':productID,
        },
      token: token
    ).then((value) {
         changeFavModel=ChangeFavModel.fromJson(value.data);
         if(!changeFavModel.status) {
           favourite[productID]=!favourite[productID];
         }
          emit(ShopSuccessChangeFavouritesState(changeFavModel));

    }).catchError((error){
      favourite[productID]=!favourite[productID];
      emit(ShopErrorChangeFavouritesState());
    });
  }

  ShopLoginModel loginModel ;
  void getProfile()
  {
    DioHelper.getData(
        url: profile,
        token: token
    ).then((value) {
      loginModel=ShopLoginModel.FromJson(value.data);
      emit(ShopSuccessProfileState());
    }).catchError((error){
      emit(ShopErrorProfileState());
    });
  }

  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }){
    emit(UpdateDataLoadingState());
    DioHelper.putData(
        url: updateProfile,
        data: {
          'name':name,
          'email':email,
          'phone':phone,
        },
    token: token).then((value) =>{
      loginModel = ShopLoginModel.FromJson(value.data),
      emit(UpdateDataSuccessState())

    }).catchError((error){
      emit(UpdateDataErrorState());
    });
  }
}