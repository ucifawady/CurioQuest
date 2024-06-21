import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/components.dart';
import '../Navy_login/navy_login_screen.dart';
import '../auth_service.dart';
import 'cubit/cubit_register.dart';
import 'cubit/state_register.dart';

class NavyRegisterScreen extends StatefulWidget {
  @override
  State<NavyRegisterScreen> createState() => _NavyRegisterScreenState();
}

class _NavyRegisterScreenState extends State<NavyRegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  bool navigateToLogin = false;
  int selectedAvatarIndex = 0;

  final List<CircleAvatar> avatars = [
    CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage('assets/images/p1.png'),
    ),
    CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage('assets/images/p2.png'),
    ),
    CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage('assets/images/p3.png'),
    ),
    CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage('assets/images/p4.png'),
    ),
    CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage('assets/images/p5.png'),
    ),
  ];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NavyRegisterCubit(),
      child: BlocListener<NavyRegisterCubit, NavyRegisterStates>(
        listener: (context, state) {
          if (state is NavyCreateUserSuccessState) {
            navigateToLogin = true;
          } else if (state is NavyRegisterErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: BlocBuilder<NavyRegisterCubit, NavyRegisterStates>(
          builder: (context, state) {
            final Navy = NavyRegisterCubit.get(context);
            if (navigateToLogin) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => NavyLoginScreen()),
                );
              });
            }
            return Scaffold(
              body: Stack(
                children: [
                  Image.asset(
                    'assets/images/wall3.jpg',
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'SIGN UP',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text('     Choose your avatar',style: TextStyle(color: Colors.black),),
                              SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: avatars.asMap().entries.map((entry) {
                                    final int index = entry.key;
                                    final Widget avatar = entry.value;

                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedAvatarIndex = index;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8), // Adjust padding as needed
                                        decoration: BoxDecoration(
                                          border: selectedAvatarIndex == index
                                              ? Border.all(color: Colors.deepOrange, width: 2) // Add border for selected avatar
                                              : null,
                                          borderRadius: BorderRadius.circular(8), // Adjust border radius as needed
                                        ),
                                        child: avatar,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(height: 30),
                              defaultFormField(
                                controller: nameController,
                                type: TextInputType.name,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'please enter your name';
                                  }
                                },
                                label: 'Username',
                                prefix: Icons.person,
                              ),
                              SizedBox(height: 30),
                              defaultFormField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'please enter your email address';
                                  }
                                },
                                label: 'Email Address',
                                prefix: Icons.email_outlined,
                              ),
                              SizedBox(height: 15),
                              defaultFormField(
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                onSubmit: (context) {},
                                suffix: Navy.suffix,
                                suffixPressed: () {
                                  Navy.changePasswordVisibility();
                                },
                                isPassword: Navy.isPassword,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'password is too short';
                                  }
                                },
                                label: 'password',
                                prefix: Icons.lock_outline,
                              ),
                              SizedBox(height: 30),
                              defaultFormField(
                                controller: phoneController,
                                type: TextInputType.phone,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'please enter your phone';
                                  }
                                },
                                label: 'Phone number',
                                prefix: Icons.phone,
                              ),
                              SizedBox(height: 30),
                              ConditionalBuilder(
                                condition: state is! NavyRegisterLoadingState,
                                builder: (context) => Center(
                                  child: defaultButton(
                                    width: 200,
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        Navy.userRegister(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                          avatarIndex: selectedAvatarIndex, // Pass the selected avatar index
                                        );
                                      }
                                    },
                                    text: 'register',
                                  ),
                                ),
                                fallback: (context) => Center(child: CircularProgressIndicator()),
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}