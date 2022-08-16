import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/modules/news_app/shared/network/remote/dio_helper.dart';
import '../../../models/shoppingModels/shopLoginModel.dart';
import '../../news_app/shared/network/end_points.dart';
import 'loginStates.dart';

class ShoppingCubit extends Cubit<LoginStates>{
  ShoppingCubit() : super(LoginInitialState());
  static ShoppingCubit get(context) => BlocProvider.of(context);
  ShoppingLoginModel? shoppingLoginModel;
void UserLogin({
  required String email,
  required String password,
}){
emit(LoginLoadingState());
  DioHelper.postData(url: LOGIN,
      data: {
    'email':email,
    'password':password
      }).then((value){
        print(value?.data);
        shoppingLoginModel=ShoppingLoginModel.fromJason(value?.data);
      /*  print(shoppingLoginModel?.data?.phone);
        print(shoppingLoginModel?.status);
        print(shoppingLoginModel?.message);
        print(shoppingLoginModel?.data?.token);*/

        emit(LoginSuccessState(shoppingLoginModel!));
  }).catchError((error) {
    emit(LoginFailState());
    print(error.toString());

  }
    );
}
IconData suffex=Icons.visibility_outlined;
bool isPassword=true;
void ShowPasswordVisibility(){
isPassword=!isPassword;
suffex=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
emit(ShowPasswordState());
}
}