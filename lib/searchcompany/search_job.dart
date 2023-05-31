

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:freelanceapp_like_fiverr/jobs/job_detail_screen.dart';
import 'package:freelanceapp_like_fiverr/jobs/jobs_screen.dart';
import 'package:freelanceapp_like_fiverr/widgets/job_widget.dart';

class SearchJob extends StatefulWidget {
  const SearchJob({super.key});

  @override
  State<SearchJob> createState() => _SearchJobState();
}

class _SearchJobState extends State<SearchJob> {
  TextEditingController _textEditingController = TextEditingController(text: "");
  String searchQuery = "";
  var querySnapshotData;


  _clearTextField(){

   
    

    setState(() {
      _textEditingController.clear();

     
      
    });



  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors:
        
        [ Colors.yellow,
        Colors.blue,
        
        ]
        )


      ),
      child: Scaffold(
       
        
        

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          

          title: TextField(

            onChanged: (value){

              setState(() {
                searchQuery = value;
               
                
              });

              



            },
            controller: _textEditingController,
            decoration: InputDecoration(
              border: InputBorder.none,

              filled: true,
              fillColor: Colors.transparent,
              hintText: "Search something",

            ),
          


          ),
          actions: [



            IconButton(onPressed: (){
              _clearTextField();


            }, icon: Icon(Icons.clear,
            color: Colors.white,
            
            ))
          ],
          
         


          leading: IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JobScreen()));
          }, icon: Icon(Icons.arrow_back_ios)),


          


        ),
        backgroundColor: Colors.transparent,

        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(stream: FirebaseFirestore.instance
        .collection("jobPublishers")
        // .orderBy("createdAt", descending: true)
        // .where("jobTitle", isGreaterThanOrEqualTo: searchQuery)
         .where("recruitment", isEqualTo: true)
        
        .snapshots(),

        builder: ((context, snapshot) {

          // if(snapshot.data == null){

          //   return Text("No data at all");

          // }
           if(snapshot.connectionState == ConnectionState.waiting){

            return CircularProgressIndicator();

          }
          else if(snapshot.hasError){
            return Text("${snapshot.error}");

          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
          
            
            itemBuilder: ((context, index) {


              var querySnapshotData = snapshot.data!.docs[index].data();

              // if(querySnapshotData["jobTitle"].toString().toLowerCase)
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

          

              //  return Text(querySnapshotData["jobTitle"]);

              // return ListTile(
              //   leading: Text(querySnapshotData["jobTitle"]),

              // );

              if(querySnapshotData["jobTitle"].toString().toLowerCase().startsWith(searchQuery.toLowerCase())){

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


           return Container() ;  

            }
            
            
            )
            
            
            );


          
        }),
        
        ),



      ),
    );
  }
}