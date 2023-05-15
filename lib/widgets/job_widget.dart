
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white24,
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),

      

      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        
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