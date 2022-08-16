import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/components/componenets/components.dart';
import '../shared/cubit/states.dart';

import '../shared/cubit/cubit.dart';


class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,CubitStates>(
      listener:(context, state) {},
      builder:(context, state) {
        var list=AppCubit.get(context).science;
        return articalBuilder(list,context);

      },

    );
  }
}
