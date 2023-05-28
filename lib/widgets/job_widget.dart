
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelanceapp_like_fiverr/jobs/job_detail_screen.dart';
import 'package:freelanceapp_like_fiverr/services/global_methods.dart';

class JobWidget extends StatefulWidget {
var jobId;
String jobTitle, jobDescription, uploadedby, userImage, name ,email, location;


  JobWidget({super.key, required this.email, required this.jobId,
  required this.jobTitle, required this.jobDescription, required this.uploadedby,
  required this.userImage, required this.name, required this.location,
  
  });

  @override
  State<JobWidget> createState() => _JobWidgetState();
}

class _JobWidgetState extends State<JobWidget> {

  void _deleteJob(){
    showDialog(context: context, builder: ((context) {

      return AlertDialog(
      actions: [
      TextButton(onPressed: () async{

      try {
        var curentUserId = FirebaseAuth.instance.currentUser!.uid;
        if(widget.uploadedby == curentUserId){
        await  FirebaseFirestore.instance.collection("jobPublishers").doc(widget.jobId).delete();
        Fluttertoast.showToast(msg: "deleted");
        Navigator.pop(context);


        }
        else{
          Navigator.pop(context);
          GlobalMethod.showErrorDialog("This cannot be deleted", context);
        }
      
      } catch (e) {
         Navigator.pop(context);
        GlobalMethod.showErrorDialog("This cannot be deleted", context);
      }
      finally{}






      }, child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        
        children: [
        Icon(Icons.delete),
        Text("delete"),


      ],
      ))

      ],

      );
      
    }));



  }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white24,
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),

      

      child: ListTile(

        onTap: (() {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (x)=>
          JobDetails(

            jobId: widget.jobId,
            uploadedBy: widget.uploadedby,
          )
          
          ));
        }),

        onLongPress: () {
          _deleteJob();
          
        },
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        // contentPadding: EdgeInsets.only(top: 50),
        
        leading: Container(
          width: 100,
          padding: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1.0,
            color: Colors.yellow,),
            ),

          ),
         
          child: Image.network(widget.userImage),


        ),

        title: Text(widget.jobTitle,
         maxLines: 1,
            overflow: TextOverflow.ellipsis,

            style: TextStyle(fontWeight: FontWeight.bold,
            ),
        
        
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          
          children: [
            Text(widget.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            
            style: TextStyle(fontWeight: FontWeight.bold,
            
            fontSize: 13),),

              Text(widget.jobDescription,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            
            style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 15),),







          ],),
        trailing: Icon(Icons.keyboard_arrow_right,
        size: 34,
        color: Colors.black,
        
        ),


      ),




    );
    
  }
}