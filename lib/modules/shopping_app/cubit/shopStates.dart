import 'package:tasks/models/shoppingModels/change_favorites_model.dart';

abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavigationState extends ShopStates{}
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}
class ShopErrorCategoriesDataState extends ShopStates{}
class ShopSuccessCategoriesDataState extends ShopStates{}
class ShopSuccessChangeFavoritesDataState extends ShopStates{}
class ShopErrorChangeFavoritesDataState extends ShopStates{}
class ShopChangeFavoritesDataState extends ShopStates{
   ChangeFavoritesModel model;

  ShopChangeFavoritesDataState(this.model,);
}
class ShopSuccessFavoritesDataState extends ShopStates{}
class ShopErrorFavoritesDataState extends ShopStates{}
