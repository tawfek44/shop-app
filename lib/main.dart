import 'package:conditional_builder_null_safety/example/example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/shared/components/constans/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio.dart';
import 'package:shop_app/shared/styles/color.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'modules/onboaring_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget startWidget;
  dynamic onBoarding= CacheHelper.getData('onBoarding');
  token= CacheHelper.getData('token');
  if(onBoarding!=null){
    if(token!=null) {
      startWidget = ShopLayout();
    } else startWidget = LoginScreen();
  }
  else startWidget = OnBoardingScreen();
  runApp(MyApp(startWidget));
}
class MyApp extends StatelessWidget {
   Widget widget;
   MyApp(this.widget);


  @override
  Widget build(BuildContext context) {
  return MultiBlocProvider(
    providers:  [
    BlocProvider <ShopLoginCubit>(
      create: (BuildContext context) => ShopLoginCubit(),
    ),
    BlocProvider<ShopLayoutCubit>(
        create: (BuildContext context) => ShopLayoutCubit()..getProfile(),
      ),
      BlocProvider<ShopRegisterCubit>(
        create: (BuildContext context) => ShopRegisterCubit(),
      ),
    ],
  child: MaterialApp(
    debugShowCheckedModeBanner: false,
    theme:ThemeData(
      primarySwatch: mainColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: mainColor,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 20.0,

      ),
    ),
    themeMode:ThemeMode.light,
    home:widget
    ),
  );
  }
}

