import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/models/shoppingModels/categoriesModel.dart';
import 'package:tasks/models/shoppingModels/shopHomeModel.dart';
import 'package:tasks/modules/news_app/shared/components/styles/colors.dart';

import '../../news_app/shared/components/componenets/components.dart';
import '../cubit/shopCubit.dart';
import '../cubit/shopStates.dart';

class ShopProductsScreen extends StatelessWidget {
  const ShopProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopChangeFavoritesDataState){
          if(!(state.model.status!)){
            ShowToast(
              message: state.model.message!,
              state: ToastStates.ERORR
            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).shopHomeModel!=null&&ShopCubit.get(context).categoriesModel!=null,
            builder: (context)=>shopProductPuilder(ShopCubit.get(context).shopHomeModel!,ShopCubit.get(context).categoriesModel!,context),
            fallback:  (context)=>Center(child: CircularProgressIndicator())
        );
      },
    );
  }

  Widget shopProductPuilder(HomeModel model,CategoriesModel categoriesModel,context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model.data.banners.map((e) =>Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage('${e.image}'),
                  fit: BoxFit.cover,

                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 2),
                    )
                  ]

                ),
                  )

                ),
  ).toList(),
              options: CarouselOptions(
                autoPlay: true,
                reverse: false,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
                height: 250,
                enableInfiniteScroll: true,
                initialPage: 0,
                autoPlayAnimationDuration: Duration(seconds: 3),
                autoPlayInterval: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,


              )
          ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text('Categories',
           style: TextStyle(
             fontWeight: FontWeight.w800,
             fontSize: 20
           ),),
         ),
          SizedBox(height: 10,),

          Padding(
           padding: const EdgeInsets.symmetric(horizontal: 8.0),
           child: Container(

             height: 50,
             child: ListView.separated(
               physics: BouncingScrollPhysics(),
                 itemBuilder: (context, index) => categoryBuilder(categoriesModel.data.data[index]),
                 separatorBuilder: (context, index) =>SizedBox(width: 15,),
               itemCount: categoriesModel.data.data.length,
             scrollDirection: Axis.horizontal,
             ),
           ),
         ),
          SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('New Products',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20
              ),),
          ),
          SizedBox(height: 10,),

          Container(
           // color: Colors.red,
            child: GridView.count(
                crossAxisCount: 2,

              children:List.generate(
                  model.data.products.length,
                      (index) => gridItemBuilder(model.data.products[index],context),

              ),
childAspectRatio: 1/1.6,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: EdgeInsets.all(10),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,

            ),
            
          )
        ],
      ),
    );
  }

Widget gridItemBuilder(Product model,context){
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

                  child: Image(image: NetworkImage(model.image),
                      width: double.infinity,

                        height: 200,
                      ),
                ),
              ),
              if(model.discount!=0)
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
                Text(model.name,style: TextStyle(fontWeight: FontWeight.w600),
maxLines: 1,
  overflow: TextOverflow.ellipsis,
),
                Row(
                  children: [
                    Text(
                     ' ${model.price.round()}',style: TextStyle(color: primaryColor,fontWeight: FontWeight.w600),
maxLines: 1,
  overflow: TextOverflow.ellipsis,
),
                    if(model.discount!=0)
                        Text(
                     ' ${model.oldPrice.round()}',
                      style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough),

),
Spacer(),
                   IconButton(
                       onPressed: (){
                         ShopCubit.get(context).changeFavorites(model.id);
                       },
                       icon: Icon(Icons.favorite,
                       color:favorite[model.id]! ? Colors.red:Colors.grey[200],
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
Widget categoryBuilder(Datum categoryDataModel){
    return Container(
      height: 40,
padding: EdgeInsets.all(10),
      child:Center(
        child: Text(categoryDataModel.name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14
          ),
        ),
      ) ,
      decoration: BoxDecoration(
        color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius:0,
              blurRadius: 1.5,
              offset: Offset(0, 0),
            )
          ]

      ),
    );
}
}
