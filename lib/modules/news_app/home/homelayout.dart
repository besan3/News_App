import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../search/search_screen.dart';
import '../shared/components/componenets/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, CubitStates>(
      listener: (context, states) {},
      builder: (context, states) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: const Text('News App'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    navigatTo(context,SearchScreen());
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.brightness_4_outlined),
                  onPressed: () {
                   // AppCubit.get(context).changeAppMode();
                  },
                ),
              ],
            ),
            body: SafeArea(child: appCubit.screens[appCubit.index]),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: appCubit.index,
                onTap: (index) {
                  appCubit.changeIndex(index);
                },
                items: appCubit.bottomNavigationBarItems));
      },
    );
  }
}
