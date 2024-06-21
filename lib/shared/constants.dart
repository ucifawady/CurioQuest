import 'package:cuiro_quest_app/layout/import_screen.dart';
import 'package:cuiro_quest_app/models/Navy_login/navy_login_screen.dart';
import 'package:cuiro_quest_app/shared/drawer.dart';
import '../components/components.dart';
import 'cashhelper.dart';

void signout (context){
  CasheHelper.removeData(key: 'uId').then((value) {
    if(value!){
      navigateTo(context, ImportScreen2());
    }
  });
  CasheHelper.removeData(key: 'name').then((value) {

  });
  CasheHelper.removeData(key: 'email').then((value) {

  });
  CasheHelper.removeData(key: 'avatarid').then((value) {

  });
}
String token='';
String uId='';
String name='';
String email ='';
String avatarid ='';