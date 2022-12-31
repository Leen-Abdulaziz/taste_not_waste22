import 'package:taste_not_waste/authentication/bloc/authentication_bloc.dart'; 
import 'package:taste_not_waste/home/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart'; 
 

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPage createState() => _ForgetPasswordPage();
}

class _ForgetPasswordPage extends State<ForgetPasswordScreen> {

  final TextEditingController _emailController = TextEditingController(); 
 
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset Password'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Your request sent successfully'),
                Text('Please chek your email to reset your pasword'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                  return MyApp();
                }), (r){
                  return false;
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) { 
        if (state is sendPassResetSuccess) {
           _showMyDialog();
          
        }
 
        
        if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: Scaffold( 
        body: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
                height:  MediaQuery.of(context).size.height * 0.7 ,
                child: CustomPaint(
                  painter: CurvePainter(true),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 0),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          child: Column( 

                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[

                                const SizedBox(
                                  height: 14,
                                ),

                                Image.asset("assets/images/logo.png", 
                                      height: 150),
                                
                                const SizedBox(
                                  height: 16,
                                ),

                                const Text(
                                  "Please write your email to reset password",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF1C1C1C),
                                    height: 1
                                  ), 
                                ),

                                const SizedBox(
                                  height: 16,
                                ),

                                TextField(
                                  controller: _emailController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
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
                                    fillColor: Colors.black,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                  ),
                                ),
              
                                const SizedBox(
                                  height: 24,
                                ),

                                Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1C1C1C),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF1C1C1C).withOpacity(0.2),
                                        spreadRadius: 3,
                                        blurRadius: 4,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          context.read<AuthenticationBloc>().add(
                                                ForgetPasswordEvent(
                                                  email: _emailController.text,
                                                  password: "",
                                                ),
                                              );
                                        },
                                        child: const Text(
                                          "Reset Password",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                  ),
                                ),

                                const SizedBox(
                                  height: 14,
                                ),

                                Container(
                                  height: 20,
                                  child: GestureDetector(
                                    onTap: () {
                                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                                              return MyApp();
                                            }), (r){
                                              return false;
                                            });
                                    },
                                    child: const Text(
                                      "Back to Login Page",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1C1C1C),
                                        height: 1,
                                      ), 
                                    ),
                                  )
                                ) ,
              
                              ],
              
                        ),
                        
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ) 
           
          
        ); 
  }
}
