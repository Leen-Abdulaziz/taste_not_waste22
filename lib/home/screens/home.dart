import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taste_not_waste/authentication/bloc/authentication_bloc.dart';
import 'package:taste_not_waste/main.dart'; 
import 'mainDrawer.dart';
import 'allegryScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auth_service/src/service/firebase_auth_service.dart'; 
import 'package:firebase_auth/firebase_auth.dart' as auth;


class Home extends StatefulWidget {
  const Home({Key? key, required this.email}) : super(key: key);
  final String email;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference allergies = FirebaseFirestore.instance.collection('users');
  
  FirebaseAuthService fAuth = FirebaseAuthService(
          authService: auth.FirebaseAuth.instance,
        );
    
 
  List data = [];

  Future<dynamic> asyncAllergyCheck() async  { 
    User? currentUser = fAuth.getUser(); 
    //DocumentSnapshot variable = await allergies.doc(currentUser!.uid).collection("allergy").doc().get();
    await allergies.doc(currentUser!.uid).collection("allergy").get().then((value) {
        for(var i in value.docs) {
          data.add(i.data());
        }
      });
    if(data == null || data.length == 0){
      noAllergyFoundAlert();
    }
  }

  Future<void> noAllergyFoundAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notification'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('You have to add allergy'), 
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                 Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>   allegryScreen()),
                        );
              },
            ),
          ],
        );
      },
    );
  }


  @override   
  void initState() {    
    asyncAllergyCheck().then((value) {    });    
    super.initState(); 

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) { 
        if (state is LogoutSuccess) {
          Fluttertoast.showToast(
              msg: "User Logged out suucessfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
            return MyApp();
          }), (r){
            return false;
          });
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
        appBar: AppBar(
            title: const Text('Taste Not Waste APP'),
             backgroundColor: Colors.green[700],),
        drawer: const mainDrawer(),
        body: const Center(child: Text('Welcome user...')),
      )
    );
  }
}

