import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cuiro_quest_app/models/Navy_login/cubit/state_login.dart';


class NavyLoginCubit extends Cubit<NavyLoginStates>{
  NavyLoginCubit(): super (NavyLoginInitialState());
static NavyLoginCubit get(context) => BlocProvider.of(context);
void userSocialLogin({
required String email,
required String password,
}){
emit(NavyLoginLoadingState());
FirebaseAuth.instance.signInWithEmailAndPassword(
email: email,
password: password).then((value){
emit(NavyLoginSuccessState(value.user!.uid));
}).catchError((error){
emit(NavyLoginErrorState(error.toString()));
});
}
IconData suffix = Icons.visibility_outlined;
bool isPassword = true;
void changePasswordVisibility(){
isPassword = !isPassword;
suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
emit(NavyChangePasswordVisibilityState());
}
}