import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../shared/components/components/components.dart';
import '../shared/components/constans/constants.dart';
class onBoardingItemModel {
   final String image;
   final String title;
   final String body;
  onBoardingItemModel(this.image, this.title, this.body);
}
class OnBoardingScreen extends StatefulWidget {

   const OnBoardingScreen({Key key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<onBoardingItemModel>list=[
    onBoardingItemModel(
      'assets/supermarket.png',
       'Search For Favourite Food Near To You',
       'onBoarding Body 1',
    ),
    onBoardingItemModel(
         'assets/supermarket (1).png',
         'onBoarding Title 2',
         'onBoarding Body 2'
    ),
  ];

  var pageController = PageController();

  bool isLast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: (){
                submit();
              },
              child: Text(
                  'SKIP',
                  style: TextStyle(color: mainColor),
              ),
          )
        ],
      ),
        body:Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
          children: [
           Expanded(
             child: PageView.builder(
               onPageChanged: (index){
                 if(index==list.length-1){
                   setState((){
                     isLast=true;
                   });
                 }
                 else {
                   setState((){
                     isLast=false;
                   });
                 }
               },
               controller: pageController,
               physics: const BouncingScrollPhysics(),
               itemBuilder: (context,index) => onBoardingItem(list[index]),
               itemCount: list.length,),
           ),
            Row(
              children: [
              SmoothPageIndicator(
                  controller: pageController,
                  effect: ExpandingDotsEffect(
                    activeDotColor: mainColor,
                    dotColor: Colors.grey,
                    expansionFactor: 3,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5
                  ),
                  count: list.length),
                const Spacer(),
                FloatingActionButton(
                 onPressed: (){
                   if(isLast){
                     submit();
                   }else{
                   pageController.nextPage(
                       duration: const Duration(
                         milliseconds: 800
                       ),
                       curve:Curves.fastLinearToSlowEaseIn
                   );
                 }
                },
                 child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
      ),
        )
    );
  }

  Widget onBoardingItem(onBoardingItemModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage(model.image.toString()),
        ),
      ),
      Text(
        model.title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0
        ),),
      SizedBox(height: 10.0,),
      Text(model.body)
    ],
  );

  void submit (){
    CacheHelper.saveData(key: "onBoarding", value: "1").then((value) {
      if(value){
       print(CacheHelper.sharedPreferences.get("onBoarding").toString());
        navigateAndFinish(context, const LoginScreen());
      }
    });


  }
}

