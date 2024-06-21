
import 'package:cuiro_quest_app/shared/cashhelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cuiro_quest_app/layout/cubit/cubit.dart';
import 'package:cuiro_quest_app/layout/cubit/states.dart';
import 'package:cuiro_quest_app/layout/home_screen.dart';
import 'package:cuiro_quest_app/layout/import_screen.dart';
import 'package:cuiro_quest_app/models/login_screen.dart';
import 'package:cuiro_quest_app/shared/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'components/components.dart';
import 'models/database_firestore.dart';

Future<void> firebaseMessagingBackgroundHandler (RemoteMessage message) async{
  print(message.data.toString());
  ShowToastt(text: 'on message background', state: ToastStates.Success);

}
late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyD2nGkC5lNC5lhPiEUHN5pMH2LMDN1MHIs',
        appId: '1:743526086197:android:b4fdd7f9411b808478237c',
        messagingSenderId: '743526086197',
        projectId: 'nmec-90b45',
        storageBucket: 'nmec-90b45.appspot.com',
      )
  );

  var tokenn =await  FirebaseMessaging.instance.getToken();
  print("token is ${tokenn.toString()}");
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    ShowToastt(text: 'on message', state: ToastStates.Success);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    ShowToastt(text: 'on message opened app', state: ToastStates.Success);

  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  sharedPreferences = await SharedPreferences.getInstance();
  await CasheHelper.init();
  var  uId = CasheHelper.Getdata(key: 'uId');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ImportScreen2(),
        routes: {
          '/profile': (context) => ProfilePage(),
          '/museums': (context) => MuseumsPage(),
          '/share': (context) => SharePage(),
          '/about-us': (context) => AboutUsPage(),
          '/login': (context) => ImportScreen2(),
        },
      );
    }
}


