// import 'package:flutter/material.dart';
// import 'package:cuiro_quest_app/layout/home_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// import 'login_screen.dart';
//
// class SignUpScreen extends StatefulWidget {
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   final birthdateController = TextEditingController();
//   bool obscureText = true;
//   bool isLoading = false;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//       SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Sign Up',
//                       style: TextStyle(fontSize: 40.0, color: Colors.orange[900],
//                         fontWeight: FontWeight.bold,//
//                       ),
//                     ),
//                     SizedBox(
//                       height: 40.0,
//                     ),
//                     TextFormField(
//                       controller: firstNameController,
//                       keyboardType: TextInputType.text,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'First name must not be empty';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'First Name',
//                         prefixIcon: Icon(Icons.person),
//                         border: OutlineInputBorder(),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.blue),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                     ),
//                     SizedBox(height: 20.0,),
//                     TextFormField(
//                       controller: lastNameController,
//                       keyboardType: TextInputType.text,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Last name must not be empty';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Last Name',
//                         prefixIcon: Icon(Icons.person),
//                         border: OutlineInputBorder(),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.blue),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                     ),
//                     SizedBox(height: 20.0,),
//                     TextFormField(
//                       controller: emailController,
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Email must not be empty';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Email Address',
//                         prefixIcon: Icon(Icons.email),
//                         border: OutlineInputBorder(),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.blue),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                     ),
//                     SizedBox(height: 20.0,),
//                     TextFormField(
//                       controller: passwordController,
//                       keyboardType: TextInputType.text,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Password must not be empty';
//                         }
//                         return null;
//                       },
//                       obscureText: obscureText,
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         prefixIcon: Icon(Icons.lock),
//                         suffixIcon: IconButton(
//                           icon: Icon(Icons.remove_red_eye),
//                           onPressed: () {
//                             setState(() {
//                               obscureText = !obscureText;
//                             });
//                           },
//                         ),
//                         border: OutlineInputBorder(),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.blue),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                     ),
//                     SizedBox(height: 20.0,),
//                     TextFormField(
//                       controller: confirmPasswordController,
//                       keyboardType: TextInputType.text,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Confirm Password must not be empty';
//                         }
//                         if (value != passwordController.text) {
//                           return 'Password and Confirm Password do not match';
//                         }
//                         return null;
//                       },
//                       obscureText: obscureText,
//                       decoration: InputDecoration(
//                         labelText: 'Confirm Password',
//                         prefixIcon: Icon(Icons.lock),
//                         suffixIcon: IconButton(
//                           icon: Icon(Icons.remove_red_eye),
//                           onPressed: () {
//                             setState(() {
//                               obscureText = !obscureText;
//                             });
//                           },
//                         ),
//                         border: OutlineInputBorder(),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.blue),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                     ),
//                     SizedBox(height: 20.0,),
//                     TextFormField(
//                       controller: birthdateController,
//                       keyboardType: TextInputType.datetime,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Birthdate must not be empty';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Birthdate',
//                         prefixIcon: Icon(Icons.calendar_today),
//                         border: OutlineInputBorder(),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.blue),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                     ),
//                     SizedBox(height: 40.0,),
//                     isLoading ? CircularProgressIndicator() :
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => LoginScreen(),
//                           ),
//                         );
//                       },
//                       child: Text('Register'),
//                     ),
//                     SizedBox(height: 20.0,),
//                     ElevatedButton(
//                       onPressed: () async {
//                         try {
//                           final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//                           final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
//                           final credential = GoogleAuthProvider.credential(
//                             accessToken: googleAuth.accessToken,
//                             idToken: googleAuth.idToken,
//                           );
//                           await FirebaseAuth.instance.signInWithCredential(credential);
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => LoginScreen(),
//                             ),
//                           );
//                         } catch (e) {
//                           print(e);
//                         }
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text('Sign in with Google'),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }