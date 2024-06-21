//
// import 'package:flutter/material.dart';
// import 'package:cuiro_quest_app/layout/home_screen.dart';
//
// import '../shared/databasehelper.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   var formkey =GlobalKey<FormState>();
//   var emailcontroller = TextEditingController();
//   var passwordcontroller = TextEditingController();
//   bool obscureText = true;
//
//   void showToast({required String message}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Image.asset(
//             'assets/images/the_mummy_art.jpeg',
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(40.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Login',
//                       style: TextStyle(fontSize: 40.0, color: Colors.white),
//                     ),
//                     SizedBox(
//                       height: 40.0,
//                     ),
//                     Container(
//                       height: 70.0,
//                       width: double.infinity,
//                       child: TextFormField(
//                         style: TextStyle(color: Colors.white),
//                         controller: emailcontroller,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.email, color: Colors.white),
//                             label: Text(
//                               'Email Address',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20.0),
//                             )),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     Container(
//                       height: 70.0,
//                       width: double.infinity,
//                       child: TextFormField(
//                         style: TextStyle(color: Colors.white),
//                         controller: passwordcontroller,
//                         obscureText: obscureText,
//                         keyboardType: TextInputType.visiblePassword,
//                         decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.lock_open, color: Colors.white),
//                             suffixIcon: IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   obscureText =!obscureText;
//                                 });
//                               },
//                               icon: Icon(Icons.remove_red_eye_outlined, color: Colors.white),
//                             ),
//                             label: Text('Password', style: TextStyle(color: Colors.white)),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20.0),
//                             )),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     ElevatedButton(
//                       onPressed: () async {
//                         if (emailcontroller.text.isEmpty || passwordcontroller.text.isEmpty) {
//                           showToast(message: 'Please enter email and password');
//                           return;
//                         }
//
//                         DatabaseHelper db = DatabaseHelper.instance;
//                         User? user = await db.login(emailcontroller.text, passwordcontroller.text);
//                         if (user!=null) {
//                           // Clear the input fields
//                           emailcontroller.clear();
//                           passwordcontroller.clear();
//
//                           // Navigate to the home screen
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => HomeScreen(),
//                             ),
//                           );
//                         } else {
//                           showToast(message: 'Invalid email or password');
//                         }
//                       },
//                       child: Text('Sign in'),
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white, backgroundColor: Colors.orange[900], // foreground color
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10.0,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }