
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelanceapp_like_fiverr/persistent/peristent.dart';
import 'package:freelanceapp_like_fiverr/services/global_methods.dart';
import 'package:freelanceapp_like_fiverr/services/global_variable.dart';
import 'package:freelanceapp_like_fiverr/widgets/bottom_navigation_screen.dart';
import 'package:uuid/uuid.dart';

class UploadJob extends StatefulWidget {
  const UploadJob({super.key});

  @override
  State<UploadJob> createState() => _UploadJobState();
}

class _UploadJobState extends State<UploadJob> {

  TextEditingController _jobCategoryController = TextEditingController(text: "Select Job Category");
  TextEditingController _jobTitleController = TextEditingController(text: "");
  TextEditingController _jobDescriptionController = TextEditingController(text: "");
  TextEditingController _jobDeadlineController = TextEditingController(text: "Select job deadline");

  final _globalKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool keyBoardHide = false;


  DateTime? datePick;
  
Timestamp? jobDeadLineTimeStamp;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getmyData();
  }


void getmyData() async{
 DocumentSnapshot documentSnapshot = await  FirebaseFirestore.instance
  .collection("users")
  .doc(FirebaseAuth.instance.currentUser!.uid)
  .get();

 name = documentSnapshot.get("name");
 userImage = documentSnapshot.get("userImage");
 location = documentSnapshot.get("location");

 setState(() {
   
 });




}

void _uploadTaskInFirebase()async{
  if(_globalKey.currentState!.validate()){
                        if(_jobCategoryController.text == "Select Job Category" || _jobDeadlineController.text == "Select job deadline"){


                          
                        GlobalMethod.showErrorDialog("Pick everything", context);


                        }
                       

                        setState(() {
                          _isLoading = true;
                        });

                        try {
                          var _jobId = Uuid().v4();
                        await  FirebaseFirestore.instance
                          .collection("jobPublishers")
                          .doc(_jobId)
                          .set({
                            "jobCategory": _jobCategoryController.text,
                            "jobTitle": _jobTitleController.text,
                            "jobDescription": _jobDescriptionController.text,
                            "jobDeadLine": _jobDeadlineController.text,
                            "jobDeadLineTimeStamp": jobDeadLineTimeStamp,

                            "jobId": _jobId ,
                             "uploadedBy": FirebaseAuth.instance.currentUser!.uid ,
                               "email": FirebaseAuth.instance.currentUser!.email,
                           "jobComments": [],
                            "recruitment": true,
                              "createdAt": Timestamp.now() ,
                                "name": name ,
                                  "userImage": userImage ,
                                  "location": location ,
                                  "applicants": 0,






                          });

                          setState(() {
                            _isLoading = false;
                          });

                          Fluttertoast.showToast(msg: "Data is uploaded",
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.cyan
                          );
                          _jobTitleController.clear();
                          _jobDescriptionController.clear();
                          setState(() {
                            _jobCategoryController.text = "Select Job Category" ;
                            _jobDeadlineController.text = "Select job deadline" ;
                          });

                          
                        } catch (e) {
                          setState(() {
                            _isLoading = false;
                          });

                         GlobalMethod.showErrorDialog(e.toString(), context);
                        }


                        setState(() {
                          _isLoading = false;
                        });
                      
                     
                     


 }




}

  void _showTheDatePicker()async{
  datePick = await showDatePicker(context: context, 
    initialDate: DateTime.now(), 
    firstDate: DateTime(2020), 
    lastDate: DateTime(2024));

    if(datePick != null){

      setState(() {
    // timeOfDay = TimeOfDay.fromDateTime(datePick!);
        _jobDeadlineController.text = "${datePick!.year} - ${datePick!.month} - ${datePick!.day} ";
        jobDeadLineTimeStamp = Timestamp.fromMicrosecondsSinceEpoch(datePick!.microsecondsSinceEpoch);

        
      });


    }





  }


  void _showJobCategoryDialog({required Size size}){

    showDialog(
      barrierDismissible: false,
      
      
      
      context: context,
       builder: (context){

      return Container(
        
        child: AlertDialog(
          insetPadding: EdgeInsets.zero ,
         
           
        
          backgroundColor: Colors.black38,
          

          title: Text("Select Job category", style: TextStyle(fontSize: 20,
          color: Colors.white),),

          content: Container(
            width: size.width * .95,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Persistent.jobcatGory.length,
              
              itemBuilder: (context, index){

                return InkWell(
                  onTap: () {
                    setState(() {
                      _jobCategoryController.text = Persistent.jobcatGory[index];
                      Navigator.pop(context);
                      
                    });
                    
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
              child: Text("Cancel", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
            )))],

        ),
      );

     

    });

  }


  Widget _textTitles({ required String textTitle}){

    return Padding(padding: EdgeInsets.all(10.0),
    child: Text(textTitle, style: TextStyle(fontWeight: FontWeight.bold,
    fontSize: 25.0,
    color: Colors.black),),
    
    
    );


  }
  Widget _onlyTextformFieldforJobDescription({required Function function, required TextEditingController textEditingController }){

      return Padding(padding: EdgeInsets.all(10.0),
    child: InkWell(
      onTap: (() {
        function;
        
      }),
      child: TextFormField(
        
        maxLines: 4,
        maxLength: 100,
        // enabled: false,
        

        validator: (value) {

          if(value!.isEmpty) return "Value is missing";
          //else
          return null;
         
          
        },
        
        controller: textEditingController,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          
          
          // hintStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.black45,
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.black45),
          
          
          
          
          
    
        ),

        errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red))
        
    
    
      ),
    ),
    
    
    )
    );




  }

  Widget _textFormField({
  required  Function function,
  required TextEditingController textEditingController,
  required bool maxLengthpropertyEnableOrDisable,
  required int maxLength
  }){

    return Padding(padding: EdgeInsets.all(10.0),
    child: InkWell(
      onTap: (() {
        function();
        
      }),
      child: TextFormField(

        validator: (value) {
          if(value!.isEmpty) return "Value is missing";
          //else
          return null;
         
          
        },
        
        controller: textEditingController,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.white),
        maxLength: maxLength,
        enabled: maxLengthpropertyEnableOrDisable,
        decoration: InputDecoration(
          
          
          // hintStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.black45,
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.black45),
          
          
          
          
          
    
        ),

        errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red))
        
    
    
      ),
    ),
    
    
    )
    );
    


  }
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
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
 bottomNavigationBar: CurveTypeBottomNavigation(index_no: 2,),
  backgroundColor: Colors.black.withOpacity(0),


 


  body: Center(
    child: Padding(padding: EdgeInsets.all(4.0),

    child: Card(
      color: Colors.black26,

      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            
            
            children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Please fill all the fields",
              style: TextStyle(
                
                color: Colors.black,
                fontSize: 49, fontFamily: "myCustomFamilySignatra"),),
            ),

            Form(
              key: _globalKey,
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
              children: [
                _textTitles(textTitle: "Job category:"),
                _textFormField(function: (){
                  _showJobCategoryDialog(size: _size);


                },  textEditingController: _jobCategoryController, maxLengthpropertyEnableOrDisable: false, maxLength: 100 ),
                _textTitles(textTitle:"Job title:"),
                _textFormField(function: (){}, textEditingController: _jobTitleController, maxLengthpropertyEnableOrDisable: true, maxLength: 100 ),
                _textTitles(textTitle:"Job Description:"),
                _onlyTextformFieldforJobDescription(function: (){}, textEditingController: _jobDescriptionController),
                // _textFormField(function: (){}, textEditingController: _jobDescriptionController),
                  _textTitles(textTitle:"Job Deadlinedate:"),
                _textFormField(function: (){

                  _showTheDatePicker();



                }, textEditingController: _jobDeadlineController, maxLengthpropertyEnableOrDisable: false, maxLength: 100 ),

                Center(
                  child: _isLoading? Center(child: CircularProgressIndicator()) : MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
                    padding: EdgeInsets.all(8.0),
                    color: Colors.black,
                    elevation: 9,
                    
                    onPressed: (() {
                      _uploadTaskInFirebase();
                      
                     
                    


                  }),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      
                      children: [
                        Text("Post now", style: TextStyle(fontWeight: FontWeight.bold,
                    fontFamily: "myCustomFamilySignatra",
                    fontSize: 30.0,
                    color: Colors.white,
                    
                    ),
                    
                    ),
                    Icon(Icons.upload_file, color: Colors.white,)
                    
                    
                    ],),
                  ),
                  
                  ),
                )





              ],
            ))
      
           
            
      
      
          ],),
        ),
      ),


    ),
    
    
    ),

  ),


  
 ),
  
    );
  }
}