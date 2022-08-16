import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tasks/modules/shopping_app/cubit/shopCubit.dart';
import 'package:tasks/modules/shopping_app/login/login_screen.dart';
import 'modules/news_app/home/homelayout.dart';
import 'modules/news_app/shared/components/styles/themes.dart';
import 'modules/news_app/shared/constants/constants.dart';
import 'modules/news_app/shared/cubit/cubit.dart';
import 'modules/news_app/shared/cubit/states.dart';
import 'modules/news_app/shared/network/local/cache_helper.dart';
import 'modules/news_app/shared/network/remote/dio_helper.dart';
import 'modules/shopping_app/onboarding/onboarding_screen.dart';
import 'modules/shopping_app/shopLayout/shopLayout.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();
DioHelper.init();
await CacheHelper.init();

bool? isDark=CacheHelper.getDta(key: 'isDark');
bool? isSaved=CacheHelper.getDta(key: 'onBoarding');
 token=CacheHelper.getDta(key: 'token').toString();
Widget? startWidget;
if(isSaved!=null){
  if(token!=null) {
    startWidget = ShopLayout();
  }else startWidget=LogInScreen();
}else startWidget=OnBoarding_Screen();


 runApp( MyApp(
  // isDark!,
     startWidget
));
}

class MyApp extends StatelessWidget {
//final bool isDark;
Widget? startWidget;

MyApp(//this.isDark,
      this.startWidget); // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
     providers: [
BlocProvider(
        create: (BuildContext context) => AppCubit(),

    ),
BlocProvider(
        create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData(),

    ),
     ],
      child: BlocConsumer<AppCubit,CubitStates>(
listener: (context, state) {},
builder: (context, state) {
  return MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: lightTheme,
  darkTheme: darkTheme,
    home:startWidget,
       themeMode:AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,

    );
    }
));

  }
}

