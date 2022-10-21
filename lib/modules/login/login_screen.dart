import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_layout/shop_layout.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/constans/constants.dart';
import 'package:shop_app/shared/network/remote/dio.dart';

import '../../shared/components/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/states.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state) {
          if(state is ShopLoginSuccessState){
            if(state.shopLoginModel.status){
              showToast (msg: state.shopLoginModel.message,colorState: ToastStates.SUCCESS);
              CacheHelper.saveData(key: 'token', value: state.shopLoginModel.data.token).then((value) {
               token=state.shopLoginModel.data.token;
                navigateAndFinish(context,const ShopLayout());
              });
            }
            else{
              showToast (msg: state.shopLoginModel.message,colorState: ToastStates.ERROR);
            }
          }
        },
        builder: (BuildContext context, state) {
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
                        'LOGIN',
                        style: TextStyle(color: Colors.black,fontSize: 30.0,fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        'login now to browse our hot offers !!',
                        style: TextStyle(color: Colors.grey,fontSize: 18.0),
                      ),
                      const SizedBox(height: 35.0,),
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
                              ShopLoginCubit.get(context).changeObsecure();
                            },
                            icon: ShopLoginCubit.get(context).isObscure?const Icon(Icons.remove_red_eye_outlined):
                            const Icon(Icons.visibility_off),
                          ),
                          isObscure: ShopLoginCubit.get(context).isObscure
                      ),
                      const SizedBox(height: 30.0,),
                      ConditionalBuilder
                        (condition: state is! ShopLoginLoadingState,
                          builder: (context) => mainButton(
                            onPressed: (){
                              if(formKey.currentState.validate()){
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            text:'LOGIN',
                          )
                          , fallback: (context) =>const Center(child: CircularProgressIndicator())
                      ),
                      const SizedBox(height: 15.0,),
                      Row(
                        children: [
                          const Text(
                              'Don\'t have an account?'
                          ),
                          mainTextButton(
                              text: 'REGISTER'
                              , onp: (){
                            navigateTo(context, const RegisterScreen());
                          })
                        ],
                      )
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
