
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/favourites_model/fav_model.dart';
import 'package:shop_app/shared/styles/color.dart';

import '../../../layout/shop_layout/cubit/shop_layout_cubit.dart';
import '../../../modules/search/cubit/cubit.dart';

Widget mainFormField( {
  @required String label,
  @required Widget prefixIcon,
  @required FormFieldValidator<String> validate,
  @required TextEditingController controller,
  @required TextInputType type,
  Widget suffixIcon,
  bool isObscure=false,
  Function onChange
}) => TextFormField(
  decoration: InputDecoration(
    label:  Text(label),
    border: const OutlineInputBorder(),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    ),
  validator: validate,
  controller: controller,
  keyboardType: type,
  obscureText: isObscure,
  onChanged: onChange,
);

Widget mainButton({
  @required final Function onPressed,
  @required String text
}) =>MaterialButton(
    onPressed: onPressed,
    color:mainColor ,
    minWidth: double.infinity,
    height: 50.0,
    child: Text(text,
      style: const TextStyle(fontSize: 20.0,color: Colors.white),
    ),
);

Widget mainTextButton ({
  @required String text,
  @required Function onp
})=>TextButton(onPressed: onp, child: Text(text));
void navigateTo(context,screen)=>
    Navigator.push(context, MaterialPageRoute(builder: (context)=> screen));
void navigateAndFinish(context,screen) =>
    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=> screen),
        (Route<dynamic> route) => false,
);

void showToast ({@required String msg,@required ToastStates colorState}) => Fluttertoast.showToast(
  msg: msg,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: chooseToastColor(colorState),
  textColor: Colors.white,
  fontSize: 16.0
);

enum ToastStates {SUCCESS,ERROR,WARNNING}

Color chooseToastColor(colorState){
  if(colorState==ToastStates.SUCCESS){
    return Colors.green;
  }
  if(colorState==ToastStates.ERROR){
    return Colors.red;
  }
  if(colorState==ToastStates.WARNNING){
    return Colors.amber;
  }
}

Widget buildListItem(dynamic d, context,{bool isOdlPrice=true}) =>Padding(
  padding: const EdgeInsets.all(20.0),
  child:  Container(
    height: 120.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(d.image),
              width: 120.0,
              height: 200.0,
            ),
            if(d.discount!=0 && isOdlPrice)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.0),
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
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
               d.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 1.3
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    "${d.price.round().toString()}${'\$'}",
                    style: const TextStyle(
                        fontSize: 12.0,
                        color: mainColor,
                        height: 1.4
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  if(d.discount!=null&&d.discount!=0 && d.oldPrice!=null)
                    Text(
                      "${d.oldPrice.round().toString()}${'\$'}",
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
                      if(ShopLayoutCubit.get(context).favourite[d.id]==null) {
                        ShopLayoutCubit.get(context).favourite[d.id]=true;
                      } else {
                        ShopLayoutCubit.get(context).favourite[d.id]=!ShopLayoutCubit.get(context).favourite[d.id];
                      }
                      ShopLayoutCubit.get(context).changeFav(d.id);
                      ShopLayoutCubit.get(context).getFavourites();
                    },
                    icon:  CircleAvatar(
                      backgroundColor: ShopLayoutCubit.get(context).favourite[d.id]!=null&&
                          ShopLayoutCubit.get(context).favourite[d.id]? mainColor:Colors.grey,
                      child: const Icon(
                        Icons.favorite_outline,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    ),
  ),

);


