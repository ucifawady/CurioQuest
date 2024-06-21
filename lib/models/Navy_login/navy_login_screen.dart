import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cuiro_quest_app/layout/home_screen.dart';
import 'package:cuiro_quest_app/shared/cashhelper.dart';
import '../../components/components.dart';
import '../../shared/constants.dart';
import '../Navy_register/Navy_register_screen.dart';
import 'cubit/cubit_login.dart';
import 'cubit/state_login.dart';

class NavyLoginScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NavyLoginCubit(),
      child: BlocConsumer<NavyLoginCubit, NavyLoginStates>(
        listener: (context, state) {
          if (state is NavyLoginErrorState) {
            ShowToastt(text: state.error, state: ToastStates.Error);
          } else if (state is NavyLoginSuccessState) {
            CasheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              uId = state.uId;
              navigateTo(context, HomeScreen());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Image.asset(
                  'assets/images/wall3.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                SizedBox(height: 70,),
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
                                'LOGIN',
                                style: GoogleFonts.rubik(
                                  color: Colors.deepOrange,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 50),
                            Theme(
                              data: Theme.of(context).copyWith(
                                textTheme: TextTheme(
                                  bodyMedium: GoogleFonts.rubik(),
                                ),
                              ),
                              child: defaultFormField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email address';
                                  }
                                  return null;
                                },
                                label: 'Email Address',
                                prefix: Icons.email_outlined,
                              ),
                            ),
                            SizedBox(height: 35),
                            Theme(
                              data: Theme.of(context).copyWith(
                                textTheme: TextTheme(
                                  bodyMedium: GoogleFonts.rubik(),
                                ),
                              ),
                              child: defaultFormField(
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                suffix: NavyLoginCubit.get(context).suffix,
                                suffixPressed: () {
                                  NavyLoginCubit.get(context).changePasswordVisibility();
                                },
                                isPassword: NavyLoginCubit.get(context).isPassword,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password is too short';
                                  }
                                  return null;
                                },
                                label: 'Password',
                                prefix: Icons.lock_outline,
                              ),
                            ),
                            SizedBox(height: 30),
                            ConditionalBuilder(
                              condition: state is! NavyLoginLoadingState,
                              builder: (context) => Theme(
                                data: Theme.of(context).copyWith(
                                  textTheme: TextTheme(
                                    labelLarge: GoogleFonts.rubik(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                child: defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      NavyLoginCubit.get(context).userSocialLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  text: 'Login',
                                  isUpperCase: true,
                                ),
                              ),
                              fallback: (context) => Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.deepOrange)),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: GoogleFonts.rubik(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    textTheme: TextTheme(
                                      labelLarge: GoogleFonts.rubik(
                                        color: Colors.deepOrange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  child: defaultTextButton(
                                    function: () {
                                      navigateTo(context, NavyRegisterScreen());
                                    },
                                    text: 'Register',
                                  ),
                                ),
                              ],
                            ),
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
    );
  }
}
