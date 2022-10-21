import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_layout_cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_layout_states.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../shared/components/constans/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var nameController=TextEditingController();
    var emailController=TextEditingController();
    var phoneController=TextEditingController();
    ShopLayoutCubit.get(context).getProfile();

    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context,state){

      },
      builder: (context,state){
        nameController.text= ShopLayoutCubit.get(context).loginModel.data.name;
        emailController.text= ShopLayoutCubit.get(context).loginModel.data.email;
        phoneController.text= ShopLayoutCubit.get(context).loginModel.data.phone;
        return  SingleChildScrollView(
          child: ConditionalBuilder(
            condition: ShopLayoutCubit.get(context).loginModel !=null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is UpdateDataLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 20.0,),
                  mainFormField(
                      label: 'Name',
                      prefixIcon: const Icon(Icons.person),
                      validate: ( value){
                        if(value.isEmpty){
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      controller: nameController,
                      type: TextInputType.name),
                  const SizedBox(height: 20.0,),
                  mainFormField(
                      label: 'Email Address',
                      prefixIcon: const Icon(Icons.email),
                      validate: (value){
                        if(value.isEmpty){
                          return 'Email must not be empty';
                        }
                        return null;
                      },
                      controller: emailController,
                      type: TextInputType.emailAddress),

                  const SizedBox(height: 20.0,),
                  mainFormField(
                      label: 'Phone',
                      prefixIcon: const Icon(Icons.phone),
                      validate: (value){
                        if(value.isEmpty){
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                      controller: phoneController,
                      type: TextInputType.phone),
                  const SizedBox(height: 20.0,),
                  mainButton(
                      onPressed: ()
                      {
                        ShopLayoutCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                        );
                      },
                      text: 'UPDATE'),
                  const SizedBox(height: 20.0,),
                  mainButton(
                     onPressed: ()
                      {
                        signOut(context);
                      },
                      text: 'LOGOUT'),

                ],
              ),
            ),
            fallback: (context) =>const Center(child: CircularProgressIndicator(),),
          ),
        );
      },
    );


}
  void signOut(context)
  {
    CacheHelper.removeData('token').then((value) {
      if(value){
        token='';
        navigateAndFinish(context, const LoginScreen());

      }
    });
  }
}
