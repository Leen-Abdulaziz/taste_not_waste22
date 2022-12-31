import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taste_not_waste/models/Allergy.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:auth_service/src/service/firebase_auth_service.dart';  

class allegryScreen extends StatefulWidget {
  @override
  _allegryScreenState createState() => _allegryScreenState();
}

class _allegryScreenState extends State<allegryScreen> {
  
  FirebaseAuthService fAuth = FirebaseAuthService(
          authService: auth.FirebaseAuth.instance,
        );


  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 3),
    () => 'Data Loaded',
  );


  List<Allergy> all_allergies = [
    Allergy("حليب",  false),
    Allergy("الصويا",  false),
    Allergy("السمسم", false),
    Allergy("خردل",  false),
    Allergy("كرفس",  false),
    Allergy("الشوفان", false),
    Allergy("السمك",  false),
    Allergy("البيض",  false),
    Allergy("الروبيان",  false),
    Allergy("فول سوداني",  false),
    Allergy("فستق",  false),
    Allergy("حبار",  false),
    Allergy("بصل",  false),
    Allergy("ترمس",  false), 
  ];

  List<Allergy> selected_allergies = [];
  
  CollectionReference allergies = FirebaseFirestore.instance.collection('users');         

  List data = [];

  Future<dynamic> asyncAllergyCheck() async  { 
    User? currentUser = fAuth.getUser();  
    await allergies.doc(currentUser!.uid).collection("allergy").get().then((value) {
        for(var i in value.docs) {
          data.add(i.data()); 
        }
      }); 
      for (var element in data) {
        selected_allergies.add (Allergy(
                        element["title"], 
                        element["isSelected"], 
                      ));
      } 
      return data;
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.black87,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );

  @override   
  void initState() {     
    super.initState(); 

  }
  @override
  Widget build(BuildContext context) { 

    return Scaffold(
      appBar: AppBar(
        title: Text("Multi Selection ListView"),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  builder: (context, snapshot) {
 
                    if (ConnectionState.active != null && !snapshot.hasData) {
                      return Center(child: Text('Loading'));
                    }
 
                    if (ConnectionState.done != null && snapshot.hasError) {
                      return Center(child: Text("Error"));
                    }
 
                    return ListView.builder(
                        itemCount: all_allergies.length,
                        itemBuilder: (BuildContext context, int index) {
                          var tempTitle = all_allergies[index].title;
                          var tempSelected = all_allergies[index].isSelected;
                          for (var selALr in selected_allergies) {
                            if( tempTitle == selALr.title && selALr.isSelected){
                              tempSelected = true;
                            }
                          } 
                          return AllergyItem(
                            tempTitle, 
                            tempSelected,
                            index,
                          );
                        });
                  },
                  future: asyncAllergyCheck(),
                ),
 
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child:TextButton(
                    style: flatButtonStyle,
                    onPressed: () async {
                      
                      User? currentUser = fAuth.getUser();
                      var collection = FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).collection("allergy");
                      var snapshots = await collection.get();
                      for (var doc in snapshots.docs) {
                        await doc.reference.delete();
                      } 
                      
                      for (var allergy in selected_allergies) {
                        FirebaseFirestore.instance
                        .collection('users').doc(currentUser?.uid).collection("allergy").
                         add(allergy.toJson());
                      }
                      
                    },
                    child:const Text( "Update your allergies"),
                  )
                   
                ),
              )
               
              
            ],
          ),
        ),
      ),
    );
  }

  Widget AllergyItem(
      String title,  bool isSelected, int index) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green[700],
        child: Icon(
          Icons.person_outline_outlined,
          color: Colors.white,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ), 
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: Colors.green[700],
            )
          : Icon(
              Icons.check_circle_outline,
              color: Colors.grey,
            ),
      onTap: () {
        setState(() {
          all_allergies[index].isSelected = !all_allergies[index].isSelected;
          if (all_allergies[index].isSelected == true) {
            selected_allergies.add(Allergy(title, true));
          } else if (all_allergies[index].isSelected == false) {
            selected_allergies
                .removeWhere((element) => element.title == all_allergies[index].title);
          }
        });
      },
    );
  }
}

