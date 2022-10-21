

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_layout_states.dart';
import 'package:shop_app/models/category_model/category_model.dart';
import 'package:shop_app/shared/components/components/components.dart';
import 'package:shop_app/shared/styles/color.dart';

import '../../models/home_model/home_model.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopLayoutCubit cubit=ShopLayoutCubit.get(context);
    cubit.getHomeData();
    cubit.getCategoriesData();
    cubit.getFavourites();

    return  BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
       listener: (context,state){
         if(state is ShopSuccessChangeFavouritesState){
           if(state.changeFavModel.status){
             showToast(msg: state.changeFavModel.msg, colorState: ToastStates.SUCCESS);
           }
           else {
             showToast(msg: state.changeFavModel.msg, colorState: ToastStates.ERROR);
           }
         }
       },
      builder: (context,state) {
         return ConditionalBuilder(
             condition: cubit.homeModel!=null && cubit.categoriesModel!=null && cubit.favModel!=null
             , builder: (context) =>  Scaffold
              (
                body: ProductsBuilder(cubit.homeModel,cubit.categoriesModel,context)
              ),
             fallback:(context) => const Center(child: CircularProgressIndicator())
         );
      }
    );


  }
  Widget ProductsBuilder (HomeModel model, CategoriesModel categoriesModel,context) =>
      SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
    children: [
          CarouselSlider(
              items: model.data.banners.map((e) =>
                  Image(
                      image:NetworkImage(e.image.toString()),
                      width: double.infinity,
                      fit: BoxFit.cover,
                  )
              ).toList(),
              options: CarouselOptions(
                height: 250.0,
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayInterval:const Duration(seconds: 3),
                initialPage: 0,
                reverse: false,
                viewportFraction: 1.0,

              )
          ),
       const SizedBox(height: 10.0,),
       Padding(
         padding: const EdgeInsets.symmetric(
           horizontal: 10.0
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             const SizedBox(height: 10.0,),
             const Text(
                 'Categories',
                 style: TextStyle(
                   fontWeight: FontWeight.w900,
                   fontSize: 25.0,
                 ),
               maxLines: 1,
               overflow: TextOverflow.ellipsis,
             ),
             const SizedBox(height: 10.0,),
             Container(
               height: 100.0,
               child: ListView.separated(
                 physics: const BouncingScrollPhysics(),
                   shrinkWrap: true,
                   scrollDirection: Axis.horizontal,
                   itemBuilder: (context , index) =>buildCatItem(categoriesModel.data.dataModel[index]) ,
                   separatorBuilder:(context , index) =>const SizedBox(width: 10.0,) ,
                   itemCount: categoriesModel.data.dataModel.length
               ),
             ),
             const SizedBox(height: 20.0,),
             const Text(
                 'Products',
                 style: TextStyle(
                     fontWeight: FontWeight.w900,
                     fontSize: 25.0
                 ),
             ),
           ],
         ),
       ),
      const SizedBox(height: 10.0,),
       Container(
           color: Colors.white,
           child: GridView.count(
                childAspectRatio: 1/1.7,
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(model.data.products.length, (index) =>buidGridProduct(model.data.products[index],context) ),
              ),
       ),

    ],
  ),
        ),
      );
  Widget buildCatItem(DataModel dataModel) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(dataModel.image),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,
      ) ,
      Container(
        color: Colors.black.withOpacity(.7),
        width: 100.0,

        child: Text(
          dataModel.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      )

    ],
  );
  Widget buidGridProduct (Product model,context)=> Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model.image.toString()),
              width: double.infinity,
              height: 200.0,
            ),
            if(model.dicount!=0)
               Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.0),
              color: Colors.red,
              child: const Text(
                'DISCOUNT',
                style: TextStyle(
                    color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
        Text(
          model.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            height: 1.3
          ),
        ),
        Row(
          children: [
            Text(
              "${model.price.round().toString()}${'\$'}",
              style: const TextStyle(
                fontSize: 12.0,
                color: mainColor,
                height: 1.4
              ),
            ),
            const SizedBox(width: 10.0,),
            if(model.dicount!=0)
              Text(
                "${model.oldPrice.round().toString()}${'\$'}",
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
                height: 1.4,
                decoration: TextDecoration.lineThrough
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: (){
                  if(ShopLayoutCubit.get(context).favourite[model.id]==null) {
                    ShopLayoutCubit.get(context).favourite[model.id]=true;
                  } else {
                    ShopLayoutCubit.get(context).favourite[model.id]=!ShopLayoutCubit.get(context).favourite[model.id];
                  }
                  ShopLayoutCubit.get(context).changeFav(model.id);
                },
                icon:  CircleAvatar(
                  backgroundColor: ShopLayoutCubit.get(context).favourite[model.id]!=null&&
                      ShopLayoutCubit.get(context).favourite[model.id]? mainColor:Colors.grey,
                    child: const Icon(
                      Icons.favorite_outline,
                      size: 15,
                      color: Colors.white,
                    ),
                ),
            )
          ],
        )
      ],
    ),
  );
}
