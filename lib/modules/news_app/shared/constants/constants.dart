import '../../../shopping_app/login/login_screen.dart';
import '../components/componenets/components.dart';
import '../network/local/cache_helper.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then(((value){
    navigatAndRemove(context, LogInScreen());
  }));
}

String token='';