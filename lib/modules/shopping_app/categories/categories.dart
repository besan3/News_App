import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/models/shoppingModels/categoriesModel.dart';

import '../cubit/shopCubit.dart';
import '../cubit/shopStates.dart';

class  ShopCategoriesScreen extends StatelessWidget {
  const  ShopCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var category=ShopCubit.get(context).categoriesModel!;
     return ListView.separated(

        itemBuilder: (context, index) => categoryItem(category.data.data[index]),
        separatorBuilder:(context, index) => Container(height:1,color: Colors.grey[200],),
        itemCount: category.data.data.length,physics: BouncingScrollPhysics(),);
  });}

  Widget categoryItem(Datum datum){
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(datum.image),
                  fit: BoxFit.cover,

                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 1.5,
                    offset: Offset(0, 2),
                  )
                ]

            ),
          ),
SizedBox(width: 20,),
          Text(datum.name.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14
          ),),
          Spacer(),
          IconButton(onPressed: (){},
              icon: Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
  }
}
