import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/components/components.dart';

import '../../models/favourites_model/fav_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController=TextEditingController();
    return BlocProvider<SearchCubit>(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state) {
          SearchCubit cubit=SearchCubit.get(context);
          return  Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Search',style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.white,
              elevation: 0.0,
              iconTheme: const IconThemeData(
                color: Colors.black
              )
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children:
                [
                  mainFormField
                    (
                      label: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      validate: (value){
                        if(value.isEmpty) {
                          return 'Make sure of search keyword';
                        }
                        return null;
                      },
                      controller: searchController,
                      type: TextInputType.text,
                      onChange: (String text){
                        cubit.searchProduct(text);
                      }
                  ),
                  const SizedBox(height: 10.0,),
                  if(state is SearchLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 20.0,),
                  if(state is SearchSuccessState)
                   Expanded(
                       child:ListView.separated(
                           itemBuilder: (context,index) =>buildListItem(SearchCubit.get(context).model.model.lst[index],context,isOdlPrice: false),
                           separatorBuilder:(context,index) =>const Divider(),
                           itemCount: cubit.model.model.lst.length)
                   ),




                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
