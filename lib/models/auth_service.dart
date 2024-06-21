import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/icon.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register user with email, password, and username
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String username, required Icon avatar,
  }) async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store user details in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': username,
        'email': email,
        // Add other user details as needed
      });
    } catch (e) {
      print('Error registering user: $e');
      throw e; // Re-throwing the error for handling in UI if needed
    }
  }

  // Sign in user with email and password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error signing in: $e');
      throw e; // Re-throwing the error for handling in UI if needed
    }
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Get username of current user from Firestore
  Future<String?> getCurrentUsername() async {
    String? uid = _auth.currentUser?.uid;
    if (uid != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await _firestore.collection('users').doc(uid).get();
      if (snapshot.exists) {
        return snapshot.data()?['username'];
      }
    }
    return null;
  }

  // Sign out user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
