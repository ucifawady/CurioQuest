import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget  defaultButton ({
  double width =double.infinity,
  double height= 50,
  Color background = Colors.deepOrange,
  bool isUpperCase = true,
  double radius =20,
  required VoidCallback function,
  required String text,
}) => Container(// foreground color
  height: height,
  width: width,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style:TextStyle(
        color: Colors.white,
      ) ,
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius,),
    color: background,
  ),
);

Widget defaultTextButton({
  required dynamic function,
  required String text,
}) =>TextButton(onPressed: function,
  child: Text(text.toUpperCase(),style: TextStyle(color: Colors.deepOrange),),
);
Widget defaultFormField ({
  required TextEditingController controller,
  required TextInputType type,
  dynamic onSubmit,
  dynamic onchange,
  required dynamic validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPassword = false,
  dynamic suffixPressed,
  dynamic onTap,
  bool isclickable = true,
}) => TextFormField(
  controller: controller,
  style: TextStyle(
    fontSize: 20,
    color: Colors.black,
  ),
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: onSubmit,
  onChanged: onchange,
  validator: validate,
  onTap:onTap ,
  enabled: isclickable,
  decoration: InputDecoration(
    fillColor: Colors.black,
    prefixIconColor: Colors.black,
    suffixIconColor: Colors.black,
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffix,
      ),
    ) : null,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  ),
);


Widget mydividor() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20,
  ),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
void ShowToastt({
  required String text,
  required ToastStates state,
}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);
enum ToastStates {Success , Error , Warning}
Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.Success:
      color = Colors.green;
      break;
    case ToastStates.Error:
      color = Colors.red;
      break;
    case ToastStates.Warning:
      color = Colors.amber;
      break;
  }
  return color;
}
PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) => AppBar(
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: const Icon(
      Icons.arrow_back_ios,
    ),
  ),
  title: Text(
    '$title',
  ),
  titleSpacing: 5,
  actions:actions,
);
Widget buildListProducts(model,context,{bool isOldPrice = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image!),
              height: 200,
              width: double.infinity,
            ),
            if(model.discount != 0 && isOldPrice)
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 5,),
                child: const Text(
                  'Discount',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 14,
                    height: 1.3
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.3,
                      color:  Colors.orange,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if(model.discount != 0 && isOldPrice)
                    Text(
                      '${model.oldPrice.round()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        height: 1.3,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  // IconButton(
                  //   onPressed: (){
                  //     //ShopCubit.get(context).ChangeFavorites(model.id!);
                  //   },
                  //   icon: CircleAvatar(
                  //     radius: 15,
                  //     backgroundColor: ShopCubit.get(context).favorites![model.id]! ? defaultColor : Colors.grey ,
                  //     child: const Icon(
                  //       Icons.favorite_border_outlined,
                  //       size: 14,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);


void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic> route) => false);
