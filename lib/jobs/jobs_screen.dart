

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelanceapp_like_fiverr/widgets/bottom_navigation_screen.dart';
import 'package:freelanceapp_like_fiverr/widgets/job_widget.dart';

import '../persistent/peristent.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  String jobCatergoryFilter = "";

  
  void _showJobCategoryDialogForFilter({required Size size}){

    showDialog(
      barrierDismissible: false,
      
      
      
      context: context, builder: (context){

      return Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: AlertDialog(
          backgroundColor: Colors.black38,
          

          title: Text("Select Job category", style: TextStyle(fontSize: 20,
          color: Colors.white),),

          content: Container(
            width: size.width * .9,
           
            
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Persistent.jobcatGory.length,
              
              itemBuilder: (context, index){

                return InkWell(
                  onTap: () {
                    setState(() {
                      jobCatergoryFilter = Persistent.jobcatGory[index];
                      Navigator.pop(context);

                      print(jobCatergoryFilter);
                      
                    });
                    
                  },
                  child: Row(children: [
                    Icon(Icons.forward_sharp, color: Colors.white,),
                   
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(Persistent.jobcatGory[index], style: TextStyle(color:Colors.white),),
                    ),
                
                
                  ],),


                );


              }),
          ),

          actions: [TextButton(onPressed: (() {
            Navigator.canPop(context)? Navigator.pop(context): null;
            
          }), child: Card(
            
            elevation: 9,
            
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Close", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
            )))],

        ),
      );

     

    });

  }




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(

      
      decoration: BoxDecoration(
        gradient: LinearGradient(
          
          colors: [
          Colors.orange,
          Colors.blue,

        ],
        stops: [0.2, 0.8],

        // begin: Alignment.centerLeft,
        // end: Alignment.centerRight,
        
        ),

        // gradient: RadialGradient(colors: [
        //   Colors.orange,
        //    Colors.blue,
        // ],
        // stops: [0.2, 0.10],
        
      
        
        // )


      ),

    


      child: Scaffold(
        
        
      
        appBar: AppBar(
          leading: IconButton(onPressed: (){

            _showJobCategoryDialogForFilter(size: size);

          }, icon: Icon(Icons.filter_list)),
        flexibleSpace: Container(

          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.yellow,
              Colors.blue
            ],
            stops: [0.2, 0.8],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            
            )
            
          ),


        ),
          
          
          title: Text("Job Screen"),
          centerTitle: true,),


          
        // backgroundColor: Colors.white.withOpacity(1),
       
        backgroundColor: Colors.transparent,
        

        bottomNavigationBar: CurveTypeBottomNavigation(index_no: 0,),

        body: StreamBuilder(
          stream: FirebaseFirestore.instance
          .collection("jobPublishers")
         
          .where("jobCategory", isEqualTo: jobCatergoryFilter )
           .orderBy("createdAt", descending: true)
          .snapshots(),
          
          builder:(context, snapshot){
            
        
            if(snapshot.connectionState == ConnectionState.waiting){
        
              return Center(child: CircularProgressIndicator());
            }
        
            else if(snapshot.connectionState == ConnectionState.active){
              if(snapshot.data!.docs.isNotEmpty){
        
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
        
                  
                  itemBuilder: (context, index){
                    var snapshotData = snapshot.data!.docs[index].data();
        
                    return JobWidget(
                      jobTitle: snapshotData["jobTitle"],
                      jobDescription: snapshotData["jobDescription"],
                      jobId: snapshotData["jobId"],
                      uploadedby: snapshotData["uploadedBy"],
                      userImage: snapshotData["userImage"],
                      name: snapshotData["name"],
                      location: snapshotData["location"],

                      
                      
                      email: snapshotData["email"] ,);
                    // return Text(snapshotData["email"]);
        
        
                  }
                  
                  
                  
                  );
        
        
              }
              //fetch data
        
            }

            else if(jobCatergoryFilter == null){
             return Center(child: Text("There is no jobs you are for the category you type in"));
            }
        
        
        
        
             return Center(child: Text("Something went wrong"));
          } 
          
          
          
          ),


        


      
      ),

    );
  }
}