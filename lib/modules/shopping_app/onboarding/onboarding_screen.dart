import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasks/modules/shopping_app/login/login_screen.dart';

import '../../news_app/shared/components/componenets/components.dart';
import '../../news_app/shared/components/styles/colors.dart';
import '../../news_app/shared/network/local/cache_helper.dart';
class onboardingModel{
  String image;
  String title;
  String description;

  onboardingModel({required this.image,required this.title,required this.description});
}
class OnBoarding_Screen extends StatefulWidget {
   OnBoarding_Screen({Key? key}) : super(key: key);

  @override
  State<OnBoarding_Screen> createState() => _OnBoarding_ScreenState();
}

class _OnBoarding_ScreenState extends State<OnBoarding_Screen> {
var onboardController=PageController();
bool isLast=false;

  @override
  Widget build(BuildContext context) {
    List<onboardingModel> board=[
      onboardingModel(image: 'assets/images/women.jpg', title: 'Shopping', description: 'description1'),
      onboardingModel(image: 'assets/images/father&son.jpg', title: 'title2', description: 'description2'),
      onboardingModel(image: 'assets/images/Tiny family at grocery bag with healthy food.jpg', title: 'title3', description: 'description3'),

    ];
    void submit(){
      CacheHelper.saveData(key: 'onBoarding', value: true).then(((value){
        if(value=true){
          navigatAndRemove(
              context,
              LogInScreen()
          );
        }
      }));

    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            submit();

          }, child: Text('SKIP',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (index){
                  if(index==board.length-1){
                    setState(() {
                      isLast=true;
                    });
                    print('last');
                  }else{
                    setState(() {
                      isLast=false;
                    });
                    print('not last');

                  }

                },
                itemBuilder: (context, index) => onboardingItem(
board[index]
              ),itemCount: board.length,
              controller: onboardController,
              ),
            ), SizedBox(height:30,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(count: board.length, controller: onboardController,
                  effect:ExpandingDotsEffect(
                    activeDotColor: primaryColor,
                    dotHeight: 12,
                    dotWidth: 12,
                    spacing: 5

                  ),

                ),
                FloatingActionButton(onPressed: (){
if(isLast!=true){
  onboardController.nextPage( duration: Duration(
      milliseconds: 750
  ), curve:Curves.linearToEaseOut );

}else{
  submit();

}
                },
                  child: Icon(Icons.arrow_forward_ios,
                 ),backgroundColor:primaryColor,)
              ],
            )
          ],
        ),
      ),

    );
  }
}
Widget onboardingItem(onboardingModel model){
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset('${model.image}',),
        ),
        Text('${model.title}'
        ,style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28
          ),),
        SizedBox(height:20,),

        Text('${model.description}'),
        SizedBox(height:40,),


      ],
    ),
  );
}
