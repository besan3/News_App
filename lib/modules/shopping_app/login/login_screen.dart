import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tasks/models/shoppingModels/shopLoginModel.dart';
import 'package:tasks/modules/news_app/shared/network/local/cache_helper.dart';
import 'package:tasks/modules/shopping_app/cubit/cubit.dart';
import 'package:tasks/modules/shopping_app/cubit/loginStates.dart';
import 'package:tasks/modules/shopping_app/login/register.dart';
import 'package:tasks/modules/shopping_app/shopLayout/shopLayout.dart';
import '../../news_app/shared/components/componenets/components.dart';
import '../../news_app/shared/components/styles/colors.dart';

class LogInScreen extends StatelessWidget {
   LogInScreen({Key? key}) : super(key: key);
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    return BlocProvider(
      create: (context)=>ShoppingCubit(),
      child: BlocConsumer<ShoppingCubit,LoginStates>(
          listener: (context,state){
            if(state is LoginSuccessState)
            {
              if(state.loginModel.status!){
                print(state.loginModel.message);
                print(state.loginModel.data?.token);
               CacheHelper.saveData(
                   key: 'token',
                   value: state.loginModel.data?.token
               ).then(((value){
                 navigatAndRemove(
                   context,ShopLayout()
                 );
               }));
              }else
                {
                  print(state.loginModel.message!);
                  ShowToast(state: ToastStates.ERORR, message:state.loginModel.message!);
                }

            }
          },

          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                     //   crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/logo.jpg',
                          width: 200,
                          height: 200,),

                          Text(
                            'LOGIN',
                            style: Theme.of(context).textTheme.headline4?.copyWith(
                                color: primaryColor
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            'Login now to brows our hot offers',
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 40,),
                          defaultTextForm(textInputType: TextInputType.emailAddress,
                            textEditingController: emailController, label: 'Email', iconData: Icons.email_outlined, validator: (String? value) {
                              if(value!.isEmpty) {
                                return 'Enter your email address';
                              }
                            },
                          ),
                          SizedBox(height: 20,),
                          defaultTextForm(textInputType: TextInputType.visiblePassword,
                              textEditingController: passwordController,
                              label: 'Password',
                              iconData: Icons.lock_outline,
                              onFieldSubmitted: (value){
                                if(formKey.currentState!.validate()){
                                  ShoppingCubit.get(context).UserLogin(email: emailController.text, password: passwordController.text);

                                }
                              },
                              validator: (String? value) {
                                if(value!.isEmpty) {
                                  return 'Password is too short';
                                }
                              },
                              isPassword:  ShoppingCubit.get(context).isPassword,
                              iconDataSuffixx:  ShoppingCubit.get(context).suffex,
                            onTap: (){
                            ShoppingCubit.get(context).ShowPasswordVisibility();
                            }
                          ),
                          SizedBox(height: 40,),
                          Container(
                            width: double.infinity,
                            height: 60,
                            child: ConditionalBuilder(
                              condition:state is!LoginLoadingState ,
                              builder:(context)=>MaterialButton(onPressed: (){
                               if(formKey.currentState!.validate()){
                                 ShoppingCubit.get(context).UserLogin(email: emailController.text, password: passwordController.text);

                               }
                              },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('LOGIN',style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  ),),
                                ),
                                color: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),

                                ),
                              ) ,
                              fallback: (context)=>Center(
                                child: CircularProgressIndicator(

                                ),
                              ),


                            ),
                          ),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account? '),
                              TextButton(onPressed: (){
                                navigatTo(context, RegisterScreen());
                              }, child:
                              Text('Register Now',
                              style: TextStyle(
                                color: primaryColor
                              ),),

                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),

      );

  }
}

