import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'state_register.dart';
import 'package:cuiro_quest_app/shared/usermodel.dart';

class NavyRegisterCubit extends Cubit<NavyRegisterStates> {
  NavyRegisterCubit() : super(NavyRegisterIntialState());

  static NavyRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required int avatarIndex,
  }) async {
    emit(NavyRegisterLoadingState());
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value) {
      userCreate(
        name: name,
        email: email,
        phone: phone,
        avatarIndex: avatarIndex, // Use avatarIndex here
        uId: value.user!.uid,
      );
      emit(NavyRegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NavyRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required int avatarIndex, // Accept avatarIndex as int
  }) {
    NavyUserModel model = NavyUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      avatarIndex: avatarIndex, // Pass avatarIndex to model
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value) {
      emit(NavyCreateUserSuccessState());
    }).catchError((error) {
      emit(NavyCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(NavyRegisterChangePasswordVisibilityState());
  }
}