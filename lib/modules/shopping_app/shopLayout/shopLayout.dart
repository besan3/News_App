import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/modules/news_app/shared/components/componenets/components.dart';
import 'package:tasks/modules/shopping_app/cubit/shopCubit.dart';
import 'package:tasks/modules/shopping_app/cubit/shopStates.dart';
import 'package:tasks/modules/shopping_app/search/search.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, state) {
        var cubit=ShopCubit.get(context);
        return  Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text('Retail Store',
            style: TextStyle(
              fontSize: 20
            ),),
            actions: [
               IconButton(onPressed: (){
                 navigatTo(context, ShopSearchScreen());
               },
                   icon: Icon(Icons.search))
            ],
          ),
          body:SafeArea(child: cubit.ShopScreens[cubit.currentIndex]),
          bottomNavigationBar: BottomNavigationBar(

           onTap: (index){
              cubit.changeScreenIndex(index);
           }, currentIndex: cubit.currentIndex,
           items:[
             BottomNavigationBarItem(
                 icon: Icon(Icons.home),
                 label: 'Home'
             ), BottomNavigationBarItem(
                 icon: Icon(Icons.apps),
                 label: 'Category'
             ), BottomNavigationBarItem(
                 icon: Icon(Icons.favorite),
                 label: 'Favorites'
             ), BottomNavigationBarItem(
                 icon: Icon(Icons.settings),
                 label: 'Settings'
             ),
          ],)
        );
      },

    );
  }
}
