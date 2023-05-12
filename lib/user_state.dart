
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelanceapp_like_fiverr/jobs/jobs_screen.dart';
import 'package:freelanceapp_like_fiverr/logInScreen/login_screen.dart';

class UserState extends StatelessWidget {
  const UserState({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot){
        if(userSnapshot.data == null){
          return LogInPage();

        }
        else if(userSnapshot.hasData){
          return JobScreen();

        }
        else if(userSnapshot.hasError){
          return Scaffold(body: Text("${userSnapshot.error}"),);

        }
        else if(userSnapshot.connectionState == ConnectionState.waiting){
          return Scaffold(body: Center(child: Text("Loading....")),);

        }
        //like else statment

        return Scaffold(body: Text("Something wrong happened"),);



      });
  }
}