

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelanceapp_like_fiverr/jobs/jobs_screen.dart';
import 'package:freelanceapp_like_fiverr/services/global_methods.dart';
import 'package:freelanceapp_like_fiverr/services/global_variable.dart';
import 'package:freelanceapp_like_fiverr/widgets/comment_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetails extends StatefulWidget {
  String? uploadedBy;
  String? jobId;
   JobDetails({super.key, this.uploadedBy, this.jobId});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  bool _isShowComment = false;
  bool _isCommenting = false;
  final TextEditingController _commentingController = TextEditingController(text: "");



  String autherName = "";
  String userImage = "";

  String jobCategory = "";
  String jobDescription = "";
  String jobTite = "";
  bool recruitMent = false;

  Timestamp? postDateTimeStamp;
  Timestamp? deadLineTimeStamp;


  String? postedDate;//created date

  String? deadLineDate;
  String? locationCompany;
  String? emailCompany;
  int? applicants;
  bool isDeadLineAvailable = false;


  void _getMyData() async{

  DocumentSnapshot documentSnapshot = await  FirebaseFirestore.instance
    .collection("users")
    .doc(widget.uploadedBy)
    .get();
  if(documentSnapshot == null){
    return;
  }
  else{
    autherName = documentSnapshot.get("name");
    userImage = documentSnapshot.get("userImage");
    setState(() {
      
    });


  }

  DocumentSnapshot jobDatabase = await FirebaseFirestore.instance
                                                .collection("jobPublishers")
                                                .doc(widget.jobId)
                                                .get();


  if(jobDatabase == null){ return;}
  else

{
   jobCategory = jobDatabase.get("jobCategory");
   jobTite = jobDatabase.get("jobTitle");
   jobDescription = jobDatabase.get("jobDescription");
   recruitMent = jobDatabase.get("recruitment");
   emailCompany = jobDatabase.get("email");
   locationCompany = jobDatabase.get("location");
   applicants = jobDatabase.get("applicants");

   deadLineDate = jobDatabase.get("jobDeadLine");

   var deadLineTimestamp = jobDatabase.get("jobDeadLineTimeStamp");
   var deadLineTimeStampt_to_dateTime = deadLineTimestamp.toDate();
   isDeadLineAvailable = deadLineTimeStampt_to_dateTime.isAfter(DateTime.now());



 postDateTimeStamp = jobDatabase.get("createdAt");
 var postDate = postDateTimeStamp!.toDate();
    //timestamp to datetime then datetime to year month day
 postedDate = "${postDate.year} - ${postDate.month} - ${postDate.day}";
 
  


   //
   
   setState(() {
     
   });

}







  }

  @override
  void initState() { 
    super.initState();
    
    _getMyData();

  }

  Widget _customDividerWidget(){
    return Column(

      children: [
        SizedBox(height: 5.0,),
        Divider(thickness: 5.0,
        color: Colors.grey,

        
        
        ),
        SizedBox(height: 5.0,)

      ],
    );



  }

  applyForJob(){

    Uri uriForEmail = Uri(
      scheme: "mailto",
      path: emailCompany,
      query: "subject=apply for job&body=hello, please attach resume",
    );



launchUrl(uriForEmail);





  }
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


        backgroundColor: Colors.black.withOpacity(0),
        appBar: AppBar(


          leading: IconButton(onPressed: (){
Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => JobScreen()));
          }, icon: Icon(Icons.close, size: 30, color: Colors.white,)),
          title: Text("Job detail screen"),
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
          ) ,
        ),

        body: SingleChildScrollView(
          child: Column(children: [
            Padding(

              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.black26,
                
                child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        jobTite == null?"" : jobTite,
                 

                        style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        ),


                      ),
                    ),

                    Row(children: [

                      Container(
                        height: 60,
                        width: 60,

                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 5,
                          ) ,


                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                            
                            userImage == null?"" : userImage,


                          )),

                        ),

                      ),

                      Padding(padding: EdgeInsets.only(left: 10.0),


                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                       
                        children: [
                        Text(
                          autherName == null?"no data" : autherName,

                          style: TextStyle(fontSize: 15, color: Colors.white,
                          fontWeight: FontWeight.bold,
                          
                          ),


                        ),
                         Text(
                          locationCompany == null?"" : locationCompany!,

                          style: TextStyle(fontSize: 10, 
                          fontWeight: FontWeight.bold,
                          
                          ),


                        ),


                      ],),
                      
                      
                      ),


                    ],
                    
                    
                    ), 
                    _customDividerWidget(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      
                      children: [
                        Text(applicants.toString() == null?"" : applicants.toString(),
                        style: TextStyle(fontSize: 20,
                        color: Colors.white),
                        
                        ),
                        SizedBox(width: 8.0,),
                        Text("Applicants",
                          style: TextStyle(fontSize: 20,
                          color: Colors.grey),
                        ),
                         SizedBox(width: 8.0,),
                        Icon(Icons.how_to_reg_sharp,
                        color: Colors.grey,
                        
                        size: 20.0,),



                    ],
                    
                    ),

                    FirebaseAuth.instance.currentUser!.uid != widget.uploadedBy?
                    Container() : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children: [
                        _customDividerWidget(),

                      Text("Recruitment",
                      style: TextStyle(fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal,
                      ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                        TextButton(onPressed: (){

                          if(FirebaseAuth.instance.currentUser!.uid == widget.uploadedBy){

                            

                            try {

                              FirebaseFirestore.instance
                              .collection("jobPublishers")
                              .doc(widget.jobId)
                              .update({
                                "recruitment": true

                              });

                              _getMyData();
                              
                            } catch (e) {
                              GlobalMethod.showErrorDialog("Action can't be perform", context);
                            }



                          }
                          else{
                            GlobalMethod.showErrorDialog("Action can't be perform", context);
                          }



                        }, child: Text("On",
                        style: TextStyle(fontStyle: FontStyle.italic,
                        color: Colors.white,
                        fontSize: 18),
                        
                        
                        
                        )),

                        Opacity(opacity: recruitMent == true? 1 : 0,

                        child: Icon(Icons.check_box,
                        color: Colors.green,),
                        
                        
                        ),

                         TextButton(onPressed: (){

                          if(FirebaseAuth.instance.currentUser!.uid == widget.uploadedBy){


                            try {

                              FirebaseFirestore.instance
                              .collection("jobPublishers")
                              .doc(widget.jobId)
                              .update({
                                "recruitment": false

                              });

                              
                            _getMyData();
                              
                            } catch (e) {
                              GlobalMethod.showErrorDialog("Action can't be perform", context);
                            }



                          }
                          else{
                            GlobalMethod.showErrorDialog("Action can't be perform", context);
                          }



                        }, child: Text("Off",
                        style: TextStyle(fontStyle: FontStyle.italic,
                        color: Colors.white,
                        fontSize: 18),
                        
                        
                        
                        )),

                        Opacity(opacity: recruitMent == false? 1 : 0,

                        child: Icon(Icons.check_box,
                        color: Colors.red,),
                        
                        
                        ),

                      


                      ],
                      
                      ),

                        _customDividerWidget(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text("JobDescription", style: TextStyle(fontSize: 15, color: Colors.white),),
                          Text(jobDescription == null? "" : jobDescription,
                          textAlign: TextAlign.right,
                          
                          
                          ),

                        ],
                        )



                    ],),



                  ],

                ),


              ),
              
              ),


            ),

            Padding(padding: EdgeInsets.all(8),
            child: Card(
              color: Colors.black38,

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  
                  children: [
                  Text(isDeadLineAvailable? "Actively recruiting apply for job" : "job not available" ),
                  SizedBox(height: 4,),
                  Center(
                    child: isDeadLineAvailable? MaterialButton(onPressed: (){
                      applyForJob();


                    },
                    child: Text("Easy apply now"
                    
                    ) ,
                    color: Colors.red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),


                    
                    
                    ) : Container(),
                  ),

                  _customDividerWidget(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("Uploaded date"),
                    Text(postedDate==null?"" : postedDate!),


                  ],),

                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("Deadline date"),
                    Text(deadLineDate==null? "" : deadLineDate!),


                  ],
                  
                  
                  ),
                  _customDividerWidget(),






                ],),
              ),



            ),
            
            
            ),


            Padding(padding: EdgeInsets.all(4),
            child: Card(
              color: Colors.black38,
              child: Column(children: [
                AnimatedSwitcher(duration: Duration(milliseconds: 3000),

                child: _isCommenting?Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                   key: Key("1"),
                  
                  children: [
                    Flexible(
                      flex: 3,
                      child: TextField( 
                        controller: _commentingController,
                        style: TextStyle(color: Colors.white),
                        maxLines: 6,
                        maxLength: 200,
                        keyboardType: TextInputType.text,

                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                 

                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.pink)),

                        ),

                      )
                      
                      ),

                      Flexible(
                         flex: 1,
                        
                        
                        child: Column(
                          children: [
                            MaterialButton(
                              elevation: 0,
                              
                              
                              onPressed: ()async{
                                if(_commentingController.text.length < 10){
                                  GlobalMethod.showErrorDialog("comment length can't be less than 10", context);
                                }
                                else{
                                  try {
                                  await FirebaseFirestore.instance
                                    .collection("jobPublishers")
                                    .doc(widget.jobId)
                                    .update({

                                      "jobComments": FieldValue.arrayUnion([{
                                        "userId": FirebaseAuth.instance.currentUser!.uid,
                                        "name": autherName ,
                                        "userImageUrl": userImage ,
                                        "commentBody": _commentingController.text,
                                        "time": Timestamp.now(),


                                      }
                                        
                                        




                                      ]), 




                                    });

                                  Fluttertoast.showToast(msg: "Comment is uploaded",
                                  backgroundColor: Colors.white,
                                  toastLength: Toast.LENGTH_LONG,
                                  
                                  
                                  );
                                  _commentingController.clear();


                                  } catch (e) {
                                    GlobalMethod.showErrorDialog("Something is wrong", context);
                                    // print(e); 
                                  }





                                }


                              


                            },
                            child: Text("Post",
                            style: TextStyle(fontWeight: FontWeight.bold,
                            color: Colors.blue),


                            
                            ),

                            
                            ),
                            TextButton(onPressed: (){

                              setState(() {
                                _isCommenting = false;
                                
                              });

                            }, child: Text("Cancel",
                             style: TextStyle(fontWeight: FontWeight.bold,
                            color: Colors.red),

                            
                            
                            ))


                          ],

                      )),

                  ],

                  
                  
                  
                  ) : Row(
                     key: Key("2"),
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: (){

                      
                      setState(() {
                         _isShowComment = false;
                         _isCommenting = true;
                        
                      });

                      }, icon: Icon(Icons.comment_bank_rounded, color: Colors.blue,)),
                      IconButton(onPressed: (){

                        setState(() {
                          // _isShowComment = true;
                          _isShowComment = !_isShowComment;
                          
                        });


                      }, icon: Icon(Icons.arrow_drop_down_circle,
                      color: Colors.blue,
                      
                      )),


                    ],


                  ),
                
                ),

                _isShowComment == false? Container() : Padding(padding: EdgeInsets.all(8.0),


                child: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance.collection("jobPublishers").doc(widget.jobId).get(),
                  
                  builder: (context, snapshot){

                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator()));

                    }
                    else if(!snapshot.data!["jobComments"].isNotEmpty){
                      return Text("No job comment is available at all");
                    }
                    return  ListView.separated(
                      physics: NeverScrollableScrollPhysics(),

                       shrinkWrap: true,
                       itemCount: snapshot.data!["jobComments"].length,

                      itemBuilder: (context, index){
                        var futureDataList = snapshot.data!["jobComments"];


                        return CommentWidget(
                          
                          commentTeter: futureDataList[index]["name"],
                           commentBody: futureDataList[index]["commentBody"] , 
                           commentTeterId: futureDataList[index]["userId"], 
                           commentImageUrl: futureDataList[index]["userImageUrl"]);

                        // return Text(futureDataList[index]["commentBody"]);



                      }, separatorBuilder: (BuildContext context, int index) { 
                        return Divider(thickness: 1,
                        color: Colors.grey,
                        );


                       },);




                  }),
                
                
                
                ),





              ],),

            ),
            
            ),




          ],),
        ),

      ),
    );
  }
}