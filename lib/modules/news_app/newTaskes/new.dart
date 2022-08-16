import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/components/componenets/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';


class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,CubitStates>(
      listener:(context, state) {},
      builder:(context, state) {
        var list=AppCubit.get(context).business;
        return articalBuilder(list,context);

      },

    );

  }
}
