import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'; 

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taste_not_waste/home/screens/home.dart';
import 'package:taste_not_waste/authentication/bloc/authentication_bloc.dart';
 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:auth_service/src/service/firebase_auth_service.dart';  

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> { 

  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userName = '';
  String _password = '';
  String _confirmPassword = '';

  FirebaseAuthService fAuth = FirebaseAuthService(
          authService: auth.FirebaseAuth.instance,
        );
    
 
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is SuccessState) {
          User? currentUser = fAuth.getUser();
          FirebaseFirestore.instance
                .collection('users').doc(currentUser?.uid)
                .set({
                    'id': currentUser?.uid,
                    'name': _userName,
                    'email': _userEmail});
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Home(email: _userEmail),
            ),
          );
        }
        if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[           
              const Text(
                "Sign up with",
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255 , 120, 150, 90),
                  height: 2,
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              const Text(
                "Taste Not Waste",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255 , 120, 150, 90),
                  letterSpacing: 2,
                  height: 1,
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              TextFormField( 
                style: const TextStyle(color: Colors.white), 
                decoration: InputDecoration(
                  hintText: 'Enter User Name',
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
                validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    if (value.trim().length < 4) {
                      return 'Username must be at least 4 characters in length';
                    } 
                    return null;
                  },
                  onChanged: (value) => _userName = value,
              ),

              const SizedBox(
                height: 16,
              ),


              TextFormField(
                style: const TextStyle(color: Colors.white), 
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
                validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email address';
                    }
                    // Check if the entered email has the right format
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    // Return null if the entered email is valid
                    return null;
                },
                onChanged: (value) => _userEmail = value,
              ),

              const SizedBox(
                height: 16,
              ),

              TextFormField(
                style: const TextStyle(color: Colors.white),
                obscureText: true, 
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0), 
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  }
                  if (value.trim().length < 8) {
                    return 'Password must be at least 8 characters in length';
                  }
                  // Return null if the entered password is valid
                  return null;
                },
                onChanged: (value) => _password = value,
              ),



              const SizedBox(
                height: 16,
              ),

              TextFormField(
                style: const TextStyle(color: Colors.white),
                obscureText: true, 
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0), 
                ),
                validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }

                    if (value != _password) {
                      return 'Confimation password does not match the entered password';
                    }

                    return null;
                  },
                  onChanged: (value) => _confirmPassword = value,
              ),



              const SizedBox(
                height: 24,
              ),

              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255 , 120, 150, 90),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255 , 120, 150, 90).withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 4,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                    child: GestureDetector(
                      onTap: () {
                          final bool? isValid = _formKey.currentState?.validate();
                          if (isValid == true) {
                              debugPrint('Everything looks good!');
                              debugPrint(_userEmail);
                              debugPrint(_userName);
                              debugPrint(_password);
                              debugPrint(_confirmPassword);

                              context.read<AuthenticationBloc>().add(
                                CreateAccountEvent(
                                  email: _userEmail,
                                  password: _password,
                                ),
                              );
                              
                          }
                        },
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C1C1C),
                        ),
                      ),
                    )
                ),
              ),
              const SizedBox(
                height: 24,
              ) 
              

            ],
          ),
        )
    );
  }
}
