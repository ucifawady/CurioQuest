// import 'package:flutter/material.dart';
// import 'package:cuiro_quest_app/components/components.dart';
// import 'package:cuiro_quest_app/models/Navy_login/navy_login_screen.dart';
// import 'package:cuiro_quest_app/models/login_screen.dart';
// import 'package:cuiro_quest_app/register_guest.dart';
//
// class ImportScreen extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body:
//       Stack(
//         children: [
//           Image.asset(
//             'assets/images/the_mummy_art.jpeg',
//             fit: BoxFit.cover, // Make sure the image covers the entire screen
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           SafeArea(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child:
//                   Container(),
//                   flex: 4,
//                 ),
//                 Expanded(
//                   child:
//                   Container(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'CURIO QUEST',style: TextStyle(
//                             color:Colors.white ,
//                             fontWeight:FontWeight.bold,
//                             fontSize: 40.0),
//                         ),
//                         Text(
//                           'Your Personal Museum Guide',style: TextStyle(
//                             color:Colors.white ,
//                             fontWeight:FontWeight.bold,
//                             fontSize: 15.0),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only( top: 30.0,
//                               left: 20.0,right: 20.0),
//                           child:
//                           Container(
//                             width: double.infinity,
//                             decoration: BoxDecoration(color:Colors.deepOrange[900] ,borderRadius: BorderRadius.circular(20.0)) ,
//                             child: MaterialButton(
//                               height: 50.0,
//                               onPressed: (){
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context)=> RegGest()));
//                               },
//                               child: Text('JOIN THE ADVENTURE',
//                                 style: TextStyle(color: Colors.white),),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Already have an account?',
//                                 style: TextStyle(
//                                     color:Colors.white ,
//                                     fontWeight:FontWeight.bold,
//                                     fontSize: 15.0),
//                               ),
//                               TextButton(onPressed: (){
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context)=> NavyLoginScreen()));
//                               },
//                                 child:Text('Log-in',
//                                   style: TextStyle(color: Colors.deepOrange[900]),),
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//
//                   ),
//                   flex: 3,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//
//     );
//   }
// }