import 'package:taste_not_waste/authentication/bloc/authentication_bloc.dart';
import 'package:taste_not_waste/authentication/screens/forgetPassord.dart'; 
import 'package:taste_not_waste/home/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
 

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
 

  @override
  Widget build(BuildContext context) {
    
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) { 
        if (state is UserLogin) {
           
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Home(email: _emailController.text),
            ),
          );
        }

        if (state is SuccessState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Home(email: _emailController.text),
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
                    "Please login to continue",
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
                    height: 14,
                  ),

                  TextField(
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
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
                                  LoginWithEmailAndPasswordEvent(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                          },
                          child: const Text(
                            "LOGIN",
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
                    child: GestureDetector(
                        child: const Text(
                          "FORGOT PASSWORD?",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1C1C1C),
                            height: 1,
                          ),
                          
                      ), onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  const ForgetPasswordScreen()),
                        );
                      }, 
                    ),
 
                  ),
                ], 
          ),
        ); 
  }
}
