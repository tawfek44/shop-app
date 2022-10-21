import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favourites_model/fav_model.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/constans/constants.dart';
import 'package:shop_app/shared/network/remote/dio.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel model;
  void searchProduct(String text){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: productSearch,
        data: {
          'text':text
        },
        token: token
    ).then((value) {
      emit(SearchSuccessState());
      model =SearchModel.fromJson(value.data);
    }).catchError((error){
      emit(SearchErrorState());
    });
  }


}