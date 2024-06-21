import 'package:cuiro_quest_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:cuiro_quest_app/components/components.dart';
import 'package:cuiro_quest_app/layout/home_screen.dart';
import 'package:cuiro_quest_app/models/Navy_register/Navy_register_screen.dart';
import 'package:cuiro_quest_app/models/signup_screen.dart';

import 'models/login_screen.dart';




class RegGest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/the_mummy_art.jpeg',
            fit: BoxFit.cover, // Make sure the image covers the entire screen
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color:Colors.deepOrange[900] ,
                          borderRadius: BorderRadius.circular(20.0)) ,
                      child: MaterialButton(
                        height: 50.0,
                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context)=> NavyRegisterScreen()));
                        },
                        child: Text('Register',
                          style: TextStyle(
                              color: Colors.white),),
                      ),
                    ),
                  ),
                  SizedBox( height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color:Colors.deepOrange[900] ,
                          borderRadius: BorderRadius.circular(20.0)) ,
                      child: MaterialButton(
                        height: 50.0,
                        onPressed: (){
                          uId='';
                          Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context)=> HomeScreen()));
                        },
                        child: Text('Geust',
                          style: TextStyle(
                              color: Colors.white),),
                      ),
                    ),
                  ),
                  SizedBox( height: 100.0,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
