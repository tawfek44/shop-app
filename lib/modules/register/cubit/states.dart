
import '../../../models/login_model/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}
class ShopRegisterSuccessState extends ShopRegisterStates{
  final ShopLoginModel shopRegisterModel;
  ShopRegisterSuccessState(this.shopRegisterModel);
}
class ShopRegisterErrorState extends ShopRegisterStates{
  final String error;
  ShopRegisterErrorState(this.error);
}
class ShopRegisterChangeObscureState extends ShopRegisterStates{}
class ShopSuccessRegisterState extends ShopRegisterStates{}
class ShopErrorRegisterState extends ShopRegisterStates{}
