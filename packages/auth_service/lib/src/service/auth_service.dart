import 'package:firebase_auth/firebase_auth.dart';

import '../models/models.dart'; 

abstract class AuthService { 
   
  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserEntity> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  User? getUser();

  Future <void> singOut({
    required String email,
    required String password,
  });

  Future <void> forgetPassword({
    required String email,
    required String password,
  });
}
