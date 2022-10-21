import 'package:shop_app/models/favourites_model/add_or_delete_fav.dart';
import 'package:shop_app/models/favourites_model/fav_model.dart';

abstract class ShopLayoutStates {}

class ShopLayoutInitialState extends ShopLayoutStates{}
class ShopChangeBottomNavBarState extends ShopLayoutStates{}


class ShopLoadingDataState extends ShopLayoutStates{}
class ShopSuccessDataState extends ShopLayoutStates{}
class ShopErrorDataState extends ShopLayoutStates{}

class ShopSuccessCategoriesState extends ShopLayoutStates{}
class ShopErrorCategoriesState extends ShopLayoutStates{}


class ShopSuccessFavouritesState extends ShopLayoutStates{}
class ShopErrorFavouritesState extends ShopLayoutStates{}

class ShopChangeFavouritesState extends ShopLayoutStates{}
class ShopSuccessChangeFavouritesState extends ShopLayoutStates{
  final ChangeFavModel changeFavModel;
  ShopSuccessChangeFavouritesState(this.changeFavModel);
}
class ShopErrorChangeFavouritesState extends ShopLayoutStates{}

class ShopSuccessProfileState extends ShopLayoutStates{}
class ShopErrorProfileState extends ShopLayoutStates{}


class UpdateDataLoadingState extends ShopLayoutStates{}
class UpdateDataSuccessState extends ShopLayoutStates{}
class UpdateDataErrorState extends ShopLayoutStates{}
