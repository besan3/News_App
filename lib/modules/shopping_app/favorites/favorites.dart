import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shoppingModels/get_favorites_model.dart';
import '../../news_app/shared/components/componenets/components.dart';
import '../../news_app/shared/components/styles/colors.dart';
import '../cubit/shopCubit.dart';
import '../cubit/shopStates.dart';

class  ShopFavoritesScreen extends StatelessWidget {
  const  ShopFavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopChangeFavoritesDataState){
          if(state.model.status=false){
            ShowToast(
                message: state.model.message!,
                state: ToastStates.ERORR
            );
          }
        }
      },
      builder: (context, state) {
    FavoritesModel? favoritesModel=ShopCubit.get(context).favoritesModel!;
        return Container(
height: 100,
          child: Container(
            width: 400,
            height: 100,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => favoriteItemBuilder(favoritesModel.data.data[index],context),
              separatorBuilder: (context, index) =>SizedBox(width: 15,),
              itemCount: favoritesModel.data.data.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        );
      },
    );
  }
  Widget favoriteItemBuilder(FavoritData model,context){
    var favorite=ShopCubit.get(context).favorites;
    return Container(



      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                blurRadius: 1.5,
                color: Colors.black12,
                spreadRadius: 0,
                offset: Offset(0, 0)

            )
          ]

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Expanded(
                child: Container(

                  child: Image(image: NetworkImage(model.product.image),
                    width: double.infinity,

                    height: 200,
                  ),
                ),
              ),
              if(model.product.discount!=0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: Text('Discount',style: TextStyle(color: Colors.white,fontSize: 10),),
                )
            ],
          ),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.product.name,style: TextStyle(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      ' ${model.product.price.round()}',style: TextStyle(color: primaryColor,fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if(model.product.discount!=0)
                      Text(
                        ' ${model.product.oldPrice.round()}',
                        style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough),

                      ),
                    Spacer(),
                    IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: Icon(Icons.favorite,
                          color:

    ShopCubit.get(context).favorites[model.id]!=null ? Colors.red:Colors.grey[200],
    ))
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

}
