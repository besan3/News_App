import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/modules/news_app/doneTaskes/done.dart';
import 'package:tasks/modules/news_app/shared/cubit/states.dart';
import 'package:tasks/modules/news_app/shared/network/local/cache_helper.dart';
import '../../archivedTaskes/archived.dart';
import '../../newTaskes/new.dart';
import '../network/remote/dio_helper.dart';

class AppCubit extends Cubit<CubitStates> {
  AppCubit() : super(InitialState());
  int index = 0;
  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports_basketball), label: 'Sports'),
    BottomNavigationBarItem(
        icon: Icon(Icons.science_outlined), label: 'Science'),

  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),

  ];

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  static AppCubit get(context) => BlocProvider.of(context);

  void changeIndex(int currentIndex) {
    index = currentIndex;
    if (currentIndex == 1) {
      getSportsData();
    }
    if (currentIndex == 2) {
      getScienceData();
    }
    emit(ChangeScreenState());
  }

  void getBusinessData() {
    emit(GetBusinessDataLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
   'country': 'us',
      'category': 'business',
      'apiKey': '4d5fa9c991a54baaa2ca6b195a42fc56',
    }).then((value) {
      business = value?.data['articles'];
      print(business[0]['title']);
      emit(GetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetBusinessErrorState(error.toString()));
    });
  }

  void getSportsData() {
    emit(GetSportsDataLoadingState());

      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': '4d5fa9c991a54baaa2ca6b195a42fc56',
      }).then((value) {
        sports = value?.data['articles'];
        print(sports[0]['title']);
        emit(GetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetSportsErrorState(error.toString()));
      });


  }

  void getScienceData() {
    emit(GetScienceDataLoadingState());


      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'science',
        'apiKey': '4d5fa9c991a54baaa2ca6b195a42fc56',
      }).then((value) {
        science = value?.data['articles'];
        print(science[0]['title']);
        emit(GetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetScienceErrorState(error.toString()));
      });

  }
  void getSearchData(String  value) {
    search=[];
    emit(GetSearchDataLoadingState());


    DioHelper.getData(url: 'v2/everything', query: {
      'q': '${value}',
      'apiKey': '4d5fa9c991a54baaa2ca6b195a42fc56',
    }).then((value) {
      search = value?.data['articles'];
      print(search[0]['title']);
      emit(GetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSearchErrorState(error.toString()));
    });

  }



bool isDark=false;
  void changeAppMode({bool? isShared}){
    if(isDark!=null){
      isDark=isShared!;
      emit(AppChangeModeState());
    }
    else{
      isDark=!isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) => emit(AppChangeModeState()));

    }



  }
}
