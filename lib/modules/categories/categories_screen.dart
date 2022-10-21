import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_layout_states.dart';

import '../../models/category_model/category_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context,state){},
      builder: (context,state) =>ListView.separated(
          itemBuilder: (context,index)=> buildCatItem(ShopLayoutCubit.get(context).categoriesModel.data.dataModel[index]),
          separatorBuilder: (context,index) =>const Divider(height: 1.0,),
          itemCount: ShopLayoutCubit.get(context).categoriesModel.data.dataModel.length),
    );
  }
 Widget buildCatItem(DataModel dataModel) =>  Padding(
   padding: const EdgeInsets.all(20.0),
   child: Row(
     children:  [
       Image(
         image: NetworkImage(dataModel.image),
         height: 80.0,
         width: 80.0,
         fit: BoxFit.cover,
       ),
       const SizedBox(width: 20.0,),
       Text(
         dataModel.name,
         style: const TextStyle(
             color: Colors.black,
             fontSize: 20.0,
             fontWeight: FontWeight.bold
         ),
       ),
       const Spacer(),
       const Icon(
           Icons.arrow_forward_ios
       )
     ],
   ),
 );
}
