import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/shop_layout/shop_layout.dart';
import '../../shared/components/components/components.dart';
import '../../shared/components/constans/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login/cubit/states.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var userNameController = TextEditingController();
    var formKey = GlobalKey<FormState>();


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme:const IconThemeData(
          color: Colors.black
        ) ,
      ),

      body: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
       listener: (context ,state){
         if(state is ShopRegisterSuccessState){
           if(state.shopRegisterModel.status){
             showToast (msg: state.shopRegisterModel.message,colorState: ToastStates.SUCCESS);
             CacheHelper.saveData(key: 'token', value: state.shopRegisterModel.data.token).then((value) {
               token=state.shopRegisterModel.data.token;
               navigateAndFinish(context,const ShopLayout());
             });
           }
           else{
             showToast (msg: state.shopRegisterModel.message,colorState: ToastStates.ERROR);
           }
         }
       },
        builder: (context,state){
         return Center(
           child: SingleChildScrollView(
             child: Padding(
               padding: const EdgeInsets.all(20.0),
               child: Form(
                 key: formKey,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children:  [
                     const Text(
                       'Register',
                       style: TextStyle(color: Colors.black,fontSize: 30.0,fontWeight: FontWeight.w600),
                     ),
                     const Text(
                       'Register now to browse our hot offers !!',
                       style: TextStyle(color: Colors.grey,fontSize: 18.0),
                     ),
                     const SizedBox(height: 35.0,),
                     mainFormField(
                         label: 'User Name',
                         prefixIcon: const Icon(Icons.person),
                         validate: (value){
                           if(value?.length == 0){
                             return 'Make Sure Of Your Name';
                           }
                           return null;
                         },
                         controller: userNameController
                         , type: TextInputType.name),
                     const SizedBox(height: 15.0,),
                     mainFormField(
                         label: 'Email Address',
                         prefixIcon: const Icon(Icons.email_outlined),
                         validate: (value){
                           if(value?.length == 0){
                             return 'Make Sure Of Your Email';
                           }
                           return null;
                         },
                         controller: emailController
                         , type: TextInputType.emailAddress),
                     const SizedBox(height: 15.0,),
                     mainFormField(
                         label: 'Password',
                         prefixIcon: const Icon(Icons.lock_outline),
                         validate: (value){
                           if(value?.length == 0){
                             return 'Make Sure Of Your Password';
                           }
                           return null;
                         },
                         controller: passwordController
                         , type: TextInputType.visiblePassword,
                         suffixIcon:  IconButton(
                           onPressed: () {
                             ShopRegisterCubit.get(context).changeObsecure();
                           },
                           icon: ShopRegisterCubit.get(context).isObscure?const Icon(Icons.remove_red_eye_outlined):
                           const Icon(Icons.visibility_off),
                         ),
                         isObscure: ShopRegisterCubit.get(context).isObscure
                     ),
                     const SizedBox(height: 15.0,),
                     mainFormField(
                         label: 'Phone',
                         prefixIcon: const Icon(Icons.phone),
                         validate: (value){
                           if(value?.length == 0){
                             return 'Make Sure Of Your Phone';
                           }
                           return null;
                         },
                         controller: phoneController
                         , type: TextInputType.phone),
                     const SizedBox(height: 30.0,),
                     ConditionalBuilder
                       (
                         condition: state is! ShopRegisterLoadingState,
                         builder: (context) => mainButton(
                           onPressed: (){
                             if(formKey.currentState.validate()){
                               ShopRegisterCubit.get(context).userRegister(
                                   name:userNameController.text ,
                                   email: emailController.text,
                                   password: passwordController.text,
                                   phone: phoneController.text
                               );
                             }
                           },
                           text:'REGISTER',
                         )
                         , fallback: (context) =>const Center(child: CircularProgressIndicator())
                     ),

                   ],
                 ),
               ),
             ),
           ),
         );
        },
      ),
    );
  }

}
