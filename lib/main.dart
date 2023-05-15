import 'package:flutter/material.dart';
import 'package:freelanceapp_like_fiverr/logInScreen/login_screen.dart';
import 'package:freelanceapp_like_fiverr/user_state.dart';
// Import the generated file
import 'firebase_options.dart';

import "package:firebase_core/firebase_core.dart";
void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
         primarySwatch: Colors.blue,
       // primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Scaffold(


        // body:Text("Hello", style:TextStyle(fontFamily: "myCustomFamilySignatra")))
   

        body:UserState(),
      ),
      
    
     
    );



  }
}


  
  