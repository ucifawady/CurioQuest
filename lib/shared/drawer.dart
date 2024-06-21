import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cuiro_quest_app/layout/NMEC_HOME.dart';
import 'package:cuiro_quest_app/layout/egyptm_home.dart';
import 'package:cuiro_quest_app/layout/grandem_home.dart';
import 'package:cuiro_quest_app/layout/grecorm_home.dart';
import 'package:cuiro_quest_app/models/Navy_login/cubit/cubit_login.dart';
import 'package:cuiro_quest_app/models/Navy_login/cubit/state_login.dart';
import 'package:cuiro_quest_app/models/Navy_register/Navy_register_screen.dart';
import 'package:cuiro_quest_app/shared/cashhelper.dart';
import 'package:cuiro_quest_app/shared/constants.dart';
import '../components/components.dart';
import '../layout/home_screen.dart';
import '../models/Navy_login/navy_login_screen.dart';
import '../register_guest.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
        future: getUserInfo(),
        builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            var userData = snapshot.data!.data();
            String username = userData?['name'] ?? 'Anonymous';
            String email = userData?['email'] ?? '';
            int avatarIndex = userData?['avatarIndex'] ?? 0;

            String getImageName(int index) {
              switch (index) {
                case 0:
                  return 'assets/images/p1.png';
                case 1:
                  return 'assets/images/p2.png';
                case 2:
                  return 'assets/images/p3.png';
                case 3:
                  return 'assets/images/p4.png';
                case 4:
                  return 'assets/images/p5.png';
                default:
                  return 'assets/images/default_avatar.jpg';
              }
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 160.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(getImageName(avatarIndex)),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Username: $username',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Email: $email',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Handle the guest user case
            return Padding(
              padding: const EdgeInsets.only(bottom: 160.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/default_avatar.jpg'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Username: Anonymous',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Email: ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    } else {
      // Return null for guests
      return null;
    }
  }
}




class MuseumsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Museums'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildMuseumCard('NMEC', 'assets/images/NMEC.jpg', context, NmecHome()),
          _buildMuseumCard('The Grand Egyptian Museum', 'assets/images/grand_museum.webp', context, GrandemHome()),
          _buildMuseumCard('The Egyptian Museum', 'assets/images/Egyptian_museum.JPG', context, EgyptmHome()),
          _buildMuseumCard('Greco-Roman Museum', 'assets/images/greek_museum.JPG', context, GrecormHome()),
        ],
      ),
    );
  }

  Widget _buildMuseumCard(String name, String imagePath, BuildContext context, Widget destinationPage) {
    return Card(
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          // Navigate to the museum details page
          Navigator.push(context, MaterialPageRoute(builder: (context) => destinationPage));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              imagePath,
              height: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MuseumDetailsPage extends StatelessWidget {
  final String name;

  MuseumDetailsPage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Text(name),
      ),
    );
  }
}
class SharePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Share'),
        ),
        body:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/NMEC.jpg',
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20,),
                Text(
                  'Share your experience with others!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Text(
            'Curio-Quest is a museum app that helps you explore and discover the world of museums. Our mission is to make museums more accessible and engaging for everyone.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}


class ImportScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/the_mummy_art.jpeg',
            fit: BoxFit.cover, // Make sure the image covers the entire screen
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(),
                  flex: 4,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'CURIO QUEST',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0,
                          ),
                        ),
                        Text(
                          'Your Personal Museum Guide',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30.0,
                            left: 20.0,
                            right: 20.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.deepOrange[900],
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: MaterialButton(
                              height: 50.0,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RegGest()),
                                );
                              },
                              child: Text(
                                'JOIN THE ADVENTURE',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => NavyLoginScreen()),
                                  );
                                },
                                child: Text(
                                  'Log-in',
                                  style: TextStyle(color: Colors.deepOrange[900]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class NavyLoginScreen extends StatelessWidget {
//   final formKey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => NavyLoginCubit(),
//       child: BlocConsumer<NavyLoginCubit, NavyLoginStates>(
//         listener: (context, state) {
//           if (state is NavyLoginErrorState) {
//             ShowToastt(text: state.error, state: ToastStates.Error);
//           } else if (state is NavyLoginSuccessState) {
//             CasheHelper.saveData(key: 'uId', value: state.uId).then((value) {
//               uId = state.uId;
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => HomeScreen()),
//                     (route) => false,
//               );
//             });
//           }
//         },
//         builder: (context, state) {
//           return Scaffold(
//             body: Stack(
//               children: [
//                 Image.asset(
//                   'assets/images/LoginRegister2.jpg',
//                   fit: BoxFit.fill,
//                   width: double.infinity,
//                   height: double.infinity,
//                 ),
//                 Center(
//                   child: SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Form(
//                         key: formKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Center(
//                               child: Text(
//                                 'LOGIN',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .headlineMedium
//                                     ?.copyWith(color: Colors.deepOrange),
//                               ),
//                             ),
//                             SizedBox(height: 30),
//                             defaultFormField(
//                               controller: emailController,
//                               type: TextInputType.emailAddress,
//                               validate: (value) {
//                                 if (value!.isEmpty) {
//                                   return 'Please enter your email address';
//                                 }
//                                 return null;
//                               },
//                               label: 'Email Address',
//                               prefix: Icons.email_outlined,
//                             ),
//                             SizedBox(height: 25),
//                             defaultFormField(
//                               controller: passwordController,
//                               type: TextInputType.visiblePassword,
//                               suffix: NavyLoginCubit.get(context).suffix,
//                               suffixPressed: () {
//                                 NavyLoginCubit.get(context)
//                                     .changePasswordVisibility();
//                               },
//                               isPassword:
//                               NavyLoginCubit.get(context).isPassword,
//                               validate: (value) {
//                                 if (value!.isEmpty) {
//                                   return 'Password is too short';
//                                 }
//                                 return null;
//                               },
//                               label: 'Password',
//                               prefix: Icons.lock_outline,
//                             ),
//                             SizedBox(height: 30),
//                             ConditionalBuilder(
//                               condition: state is! NavyLoginLoadingState,
//                               builder: (context) => defaultButton(
//                                 function: () {
//                                   if (formKey.currentState!.validate()) {
//                                     NavyLoginCubit.get(context).userSocialLogin(
//                                       email: emailController.text,
//                                       password: passwordController.text,
//                                     );
//                                   }
//                                 },
//                                 text: 'Login',
//                                 isUpperCase: true,
//                               ),
//                               fallback: (context) =>
//                                   Center(child: CircularProgressIndicator()),
//                             ),
//                             SizedBox(height: 15),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "Don't have an account? ",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 defaultTextButton(
//                                   function: () {
//                                     navigateTo(context, NavyRegisterScreen());
//                                   },
//                                   text: 'Register',
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

