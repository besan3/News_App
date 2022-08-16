import 'package:tasks/models/shoppingModels/shopLoginModel.dart';

abstract class LoginStates{}
class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates
{
  final ShoppingLoginModel loginModel;

  LoginSuccessState(this.loginModel);
}
class LoginFailState extends LoginStates{}
class ShowPasswordState extends LoginStates{}

