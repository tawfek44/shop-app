import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_layout_states.dart';

import '../../shared/components/components/components.dart';
import '../../shared/styles/color.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopLayoutCubit cubit=ShopLayoutCubit.get(context);
    cubit.getFavourites();
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
        listener: (context,state){},
        builder: (context,state) => ConditionalBuilder(
            condition: cubit.favModel.model.dataModelList.isNotEmpty,
            builder: (context) =>ListView.separated(
                itemBuilder: (context,index) =>buildListItem(cubit.favModel.model.dataModelList[index],context),
                separatorBuilder:(context,index) =>const Divider(),
                itemCount: cubit.favModel.model.dataModelList.length),
            fallback: (context) =>
                    const Center(
                        child: Icon(
                          Icons.heart_broken_outlined,
                          size: 100.0,
                        color: mainColor,)
                    ),
            )
        );
  }

}
