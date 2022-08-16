import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/cubit/states.dart';
import '../shared/components/componenets/components.dart';
import '../shared/cubit/cubit.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
TextEditingController searchController=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,CubitStates> (
        listener: (context, state) {},
        builder: (context,state){
          var list=AppCubit.get(context).search;
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultTextForm(textEditingController: searchController,
                    textInputType: TextInputType.text,
                    onChanged: (value){
AppCubit.get(context).getSearchData(value);
                    },
                    validator: (String? value){
                      if(value!.isEmpty){
                        print('Search must not be empty');
                      }return null;
                    },
                    label: 'Search',
                    iconData: Icons.search,
                  ),
                ),
                Expanded(child: articalBuilder(list,context,isSearch: true))
              ],
            ),
          );
    },
        );
  }
}
