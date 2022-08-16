import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/models/shoppingModels/categoriesModel.dart';
import 'package:tasks/models/shoppingModels/change_favorites_model.dart';
import 'package:tasks/models/shoppingModels/get_favorites_model.dart';
import 'package:tasks/models/shoppingModels/shopHomeModel.dart';
import 'package:tasks/modules/news_app/shared/constants/constants.dart';
import 'package:tasks/modules/news_app/shared/network/end_points.dart';
import 'package:tasks/modules/news_app/shared/network/remote/dio_helper.dart';
import 'package:tasks/modules/shopping_app/categories/categories.dart';
import 'package:tasks/modules/shopping_app/cubit/shopStates.dart';
import 'package:tasks/modules/shopping_app/favorites/favorites.dart';
import 'package:tasks/modules/shopping_app/products/products.dart';
import 'package:tasks/modules/shopping_app/setting/settings.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit(): super(ShopInitialState());
 static ShopCubit get(context)=> BlocProvider.of(context);

 int currentIndex=0;
 List <Widget> ShopScreens=
 [
   ShopProductsScreen(),
   ShopCategoriesScreen(),

   ShopFavoritesScreen(),
   ShopSettingsScreen(),
 ];
 /*List<String> ShopScreensTitels=[
   'Categories',
   'Products',
   'Favorites',
   'Settings',
 ];*/
  List<BottomNavigationBarItem> bottomNavigationBarItems=
  [
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
  ];

  void changeScreenIndex(int index){
   currentIndex=index;

   emit(ShopChangeBottomNavigationState());
 }
  HomeModel? shopHomeModel;
  CategoriesModel? categoriesModel;
  Map<int,bool> favorites={};
  FavoritesModel? favoritesModel;
void getHomeData(){
  emit(ShopLoadingHomeDataState());

  DioHelper.getData
    (
      url:HOME,
      token: token
    ).then((value){
    shopHomeModel=HomeModel.fromJson(value?.data);
    print(shopHomeModel?.status);
   /* print(shopHomeModel?.data.products[1].price);
    print(shopHomeModel?.data.products[1].discount);*/
  //  print(shopHomeModel?.data!.products[1].id);
shopHomeModel?.data.products.forEach((element) {
  favorites.addAll(
    {
      element.id:element.inFavorites,

    }
  );
});
    print(favorites.toString());

    emit(ShopSuccessHomeDataState());
    }).catchError((error)
  {

    print(error.toString());
    emit(ShopErrorHomeDataState());

  });
}
void getCategoriesData(){
  DioHelper.getData
    (
      url:GET_CATEGORIES,
     // token: token
    ).then((value){
    categoriesModel=CategoriesModel.fromJson(value?.data);
    print(categoriesModel?.status);
  //  print(shopHomeModel?.data!.products[1].id);

    emit(ShopSuccessCategoriesDataState());
    }).catchError((error)
  {

    print(error.toString());
    emit(ShopErrorCategoriesDataState());

  });
}
void getFavoritesData(){
  DioHelper.getData
    (
      url:FAVORITES,
     token: token
    ).then((value){
    favoritesModel=FavoritesModel.fromJson(value?.data);
    print(favoritesModel?.status);
  //  print(shopHomeModel?.data!.products[1].id);

    emit(ShopSuccessFavoritesDataState());
    }).catchError((error)
  {

    print(error.toString());
    emit(ShopErrorFavoritesDataState());

  });
}

ChangeFavoritesModel? changeFavoritesModel;
void changeFavorites(int productId){
  favorites[productId]=!favorites[productId]!;
  emit(ShopChangeFavoritesDataState( changeFavoritesModel!));
  DioHelper.postData(
      url: FAVORITES,
      data:
      {
        'product_id':productId
      },
    token: token
  ).then((value)
  {

      if(changeFavoritesModel?.status!=true)
        favorites[productId]=!favorites[productId]!;

    changeFavoritesModel=ChangeFavoritesModel?.fromJson(value?.data);
emit(ShopSuccessChangeFavoritesDataState());
  }
  ).catchError(
          (error)
      {
        favorites[productId]=!favorites[productId]!;

        emit(ShopErrorChangeFavoritesDataState());

      }
      );
}
}