import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../webView/web_view.dart';
Widget myDivider()=> Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 1,
      color: Colors.grey,
    ),
  );
Widget buildArticalItem(artical,context)=> InkWell(
  onTap: (){
    navigatTo(context, WebViewScreen(artical['url']));
  },
  child:   Padding(

      padding: const EdgeInsets.all(20.0),

      child: Row(

        children: [

          Container(

            width: 120,

            height: 120,

            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(15),

              image: DecorationImage(

                image: NetworkImage(

                  '${artical['urlToImage']}',),

                fit: BoxFit.cover,

              ),

            ),

          ),

          SizedBox(

            width: 20,

          ),

          Expanded(

            child: Container(

              height: 120,

              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Expanded(

                    child: Text(

                      '${artical['title']}',

                      style: Theme.of(context).textTheme.bodyText1,

                      maxLines: 3,

                      overflow: TextOverflow.ellipsis,

                    ),



                  ),

                  Text(

                    '${artical['publishedAt']}',

                    style: TextStyle(

                      color: Colors.grey,

                      fontSize: 14,

                    ),

                  ),

                ],

              ),

            ),

          )

        ],

      ),

    ),
);
Widget articalBuilder(list,context,{isSearch=false})=>ConditionalBuilder(
  condition:list.length>0 ,
  builder: (context)=>ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder:(context, index) =>  buildArticalItem(list[index],context),
      separatorBuilder: (context, index) =>myDivider(),
      itemCount: 20),
  fallback: (context)=>isSearch ? Container():const Center(child: CircularProgressIndicator(color: Colors.deepOrange,)),
);
Widget defaultTextForm({
  required TextEditingController textEditingController,
  required TextInputType textInputType,
  ValueChanged<String>? onFieldSubmitted,
  ValueChanged<String>? onChanged,
  GestureTapCallback? onTap,
  bool isPassword=false,
  required  FormFieldValidator<String> validator,
  required String label,
  required IconData iconData,
  IconData? iconDataSuffixx,
  bool isenable=true
})=>TextFormField(
  controller: textEditingController,
  keyboardType: textInputType,
  onFieldSubmitted:onFieldSubmitted,
  onChanged: onChanged,
  validator: validator,
  onTap: onTap,
  enabled:isenable,
obscureText: isPassword,
  decoration: InputDecoration(
    prefixIcon:Icon(iconData) ,
    label: Text(label),
    //icon: Icon(iconData),

    suffixIcon: Icon(iconDataSuffixx),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),


  ),


);

Future navigatTo(context,Widget widget)=> Navigator.push(context,
      MaterialPageRoute(builder: (context)=>widget)
  );
Future navigatAndRemove(context,Widget widget)=> Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>widget),
    (route)=>false
);

void ShowToast({
  required String message,
 required ToastStates state
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: shooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
  enum ToastStates{SUCCESS,ERORR,WARNING}
  Color shooseToastColor(ToastStates state){
   Color color;
    switch(state){
      case ToastStates.SUCCESS:
        color= Colors.green;
      break;
      case ToastStates.ERORR:
        color= Colors.red;
      break;
      case ToastStates.WARNING:
        color= Colors.amber;
      break;
  }
return color;
  }

