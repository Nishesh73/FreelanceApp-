
import 'package:flutter/material.dart';
import 'package:freelanceapp_like_fiverr/widgets/bottom_navigation_screen.dart';

class UploadJob extends StatefulWidget {
  const UploadJob({super.key});

  @override
  State<UploadJob> createState() => _UploadJobState();
}

class _UploadJobState extends State<UploadJob> {

  TextEditingController _jobCategoryController = TextEditingController(text: "Select Job Category");
  TextEditingController _jobTitleController = TextEditingController(text: "");
  TextEditingController _jobDescriptionController = TextEditingController(text: "");
  TextEditingController _jobDeadlineController = TextEditingController(text: "");


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
  required TextEditingController textEditingController
  }){

    return Padding(padding: EdgeInsets.all(10.0),
    child: InkWell(
      onTap: (() {
        function;
        
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
  appBar: AppBar(title: Text("Upload the job now"),
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
  body: Center(
    child: Padding(padding: EdgeInsets.all(8.0),

    child: Card(
      color: Color.fromARGB(97, 241, 228, 228),

      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Please fill all the fields",
              style: TextStyle(
                
                color: Colors.black,
                fontSize: 49, fontFamily: "myCustomFamilySignatra"),),
            ),

            Form(
              key: null,
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textTitles(textTitle: "Job category:"),
                _textFormField(function: (){},  textEditingController: _jobCategoryController),
                _textTitles(textTitle:"Job title:"),
                _textFormField(function: (){}, textEditingController: _jobTitleController),
                _textTitles(textTitle:"Job Description:"),
                _onlyTextformFieldforJobDescription(function: (){}, textEditingController: _jobDescriptionController),
                // _textFormField(function: (){}, textEditingController: _jobDescriptionController),
                  _textTitles(textTitle:"Job Deadlinedate:"),
                _textFormField(function: (){}, textEditingController: _jobDeadlineController),





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