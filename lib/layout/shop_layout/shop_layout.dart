import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_layout_states.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (BuildContext context, state) {

    },
      builder: (BuildContext context,state){
        var cubit = ShopLayoutCubit.get(context);
       return Scaffold(
         backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
                "Salla",
              style: TextStyle(
                color: Colors.black,
               fontWeight: FontWeight.bold,
              ),
            ),
            elevation: 0.0,
            actions: [
            IconButton(
                onPressed: (){
                  navigateTo(context, const SearchScreen());
                },
                icon: const Icon(Icons.search,color: Colors.black,
                )
            )
            ],

          ),
          body: cubit.bottomNavScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favourites'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
            ],
          ),
        );
      }
    );
  }
}
