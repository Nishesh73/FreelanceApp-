
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalMethod{


  static showErrorDialog(String error, BuildContext context){

    showDialog(
      barrierDismissible: false,
      context: context, builder: (context){
      

      return AlertDialog(
        
         
        title: Row(children: [
          Icon(Icons.error_outline),
          Text("Error Occured", style: TextStyle(color: Colors.red),),
          

        ],),
        content: Text(error),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);

            
          }, child: Text("Ok"))

        ],
        
        
       
       
      

      );




    });


  }




}