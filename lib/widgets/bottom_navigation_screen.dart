

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelanceapp_like_fiverr/jobs/jobs_screen.dart';
import 'package:freelanceapp_like_fiverr/jobs/upload_job_now.dart';
import 'package:freelanceapp_like_fiverr/searchcompany/profile_screen.dart';
import 'package:freelanceapp_like_fiverr/searchcompany/search_company_screen.dart';
import 'package:freelanceapp_like_fiverr/user_state.dart';

class CurveTypeBottomNavigation extends StatelessWidget {
   CurveTypeBottomNavigation({super.key, required this.index_no});

  int index_no = 0;

  void _logoutDialogBox(BuildContext context){

    showDialog(
      barrierDismissible: false,
      
      context: context, builder: (context){

      return AlertDialog(
        
        backgroundColor: Colors.black54,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.logout, color: Colors.white,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Log out", style: TextStyle(
                fontFamily: "myCustomFamilySignatra",
                color: Colors.white,
                
                fontWeight: FontWeight.bold, fontSize: 34),
              ),
            )

          ],),
        ),

        content: Text("Do you want to log out?", style: TextStyle(color: Colors.white),),
        actions: [TextButton(onPressed: (){
          Navigator.canPop(context)?Navigator.pop(context):null;


        }, child: Text("No", style: TextStyle(color: Colors.green),)),
        TextButton(onPressed: () async{
          Navigator.canPop(context)? Navigator.pop(context):null;
await FirebaseAuth.instance.signOut();
Navigator.push(context, MaterialPageRoute(builder: (context) => UserState()));


          


        }, child: Text("Yes", style: TextStyle(color: Colors.green),))],

      );


    });
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 50.0,
    backgroundColor: Colors.blueAccent,
    color: Colors.yellow,
    animationCurve: Curves.easeOutCirc ,
    animationDuration: Duration(milliseconds: 100) ,
    items: <Widget>[
      Icon(Icons.list, size: 18),
      Icon(Icons.search, size: 18,),
      Icon(Icons.add, size: 18,),
      Icon(Icons.person),
      Icon(Icons.logout_outlined),
      
    ],

     index: index_no ,
    

    onTap: ((indexNo) {
      if(indexNo == 0){
        Navigator.push(context, MaterialPageRoute(builder: (context) => JobScreen()));

       
      }
      else if(indexNo == 1){
        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchCompany()));

      


      }else if(indexNo == 2){
         Navigator.push(context, MaterialPageRoute(builder: (context) => UploadJob()));



      }
      else if(indexNo == 3){
         Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileCompany(

          specificId: FirebaseAuth.instance.currentUser!.uid,
         )));



      }
      else if(indexNo == 4){
        _logoutDialogBox(context);


      }
      
    }),
    );
  }
}