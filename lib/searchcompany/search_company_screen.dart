

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelanceapp_like_fiverr/widgets/bottom_navigation_screen.dart';
import 'package:freelanceapp_like_fiverr/widgets/job_widget.dart';

class SearchCompany extends StatefulWidget {
  const SearchCompany({super.key});

  @override
  State<SearchCompany> createState() => _SearchCompanyState();
}

class _SearchCompanyState extends State<SearchCompany> {
  String searchQuery = "";
  


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

        gradient: LinearGradient(colors: [
          Colors.yellow,
           Colors.blue,
         
         

        ],

        stops: [0.2, 0.8],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        
        )


      ),

child: Scaffold(
  bottomNavigationBar: CurveTypeBottomNavigation(index_no: 1,),
  backgroundColor: Colors.black.withOpacity(0),
  appBar: AppBar(
    
    title: TextField(

      onChanged: (value) {
        


        setState(() {
          searchQuery = value;
          
        });

        
        



          
      
        
      },


    ),
  
  centerTitle: true,
  flexibleSpace: Container(
     decoration: BoxDecoration(

        gradient: LinearGradient(colors: [
          Colors.yellow,
           Colors.blue,
         
         

        ],

        stops: [0.2, 0.8],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        
        ) 


      ),

  ),

  

  
  ),

  body: StreamBuilder(stream:FirebaseFirestore.instance
  .collection("jobPublishers")
  
  .snapshots(),
  builder: ((context, snapshot) {
    
 if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());


        }


    return ListView.builder(
      

      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        var querySnapshotData = snapshot.data!.docs[index].data();
        


      if(snapshot.hasData){

          if(searchQuery.isEmpty){
             return JobWidget(
              email: querySnapshotData["email"],
             jobId: querySnapshotData["jobId"], 
             jobTitle: querySnapshotData["jobTitle"], 
             jobDescription: querySnapshotData["jobDescription"] , 
             uploadedby: querySnapshotData["uploadedBy"], 
             userImage: querySnapshotData["userImage"], 
             name: querySnapshotData["name"], 
             location: querySnapshotData["location"]
             
             );

            
          }

          else if(querySnapshotData["jobTitle"].toString().toLowerCase().startsWith(searchQuery.toLowerCase())){
             return JobWidget(
              email: querySnapshotData["email"],
             jobId: querySnapshotData["jobId"], 
             jobTitle: querySnapshotData["jobTitle"], 
             jobDescription: querySnapshotData["jobDescription"] , 
             uploadedby: querySnapshotData["uploadedBy"], 
             userImage: querySnapshotData["userImage"], 
             name: querySnapshotData["name"], 
             location: querySnapshotData["location"]
             
             );


          }


      

  

        

        }

        return Container(
          child: Text("wait"),
        );



      

        


        
      },


    );
    
  }),
  
  
   ),
  
 ),
  
    );


  }
}