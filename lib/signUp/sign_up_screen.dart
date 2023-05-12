
import 'dart:io';



import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:freelanceapp_like_fiverr/logInScreen/login_screen.dart';
import 'package:freelanceapp_like_fiverr/services/global_methods.dart';
import 'package:freelanceapp_like_fiverr/services/global_variable.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  final _signUpKey = GlobalKey<FormState>();
  String name = "";
  String email = "";
  String password = "";
  String phoneNumber = "";
  String companyAddress = "";
  bool _obscureText = true;
  String imageUrl = "";

  bool _isLoading = false;


  
  AnimationController? _animationController;
  Animation? _animation;

  Uint8List? uint8list;

//  File? xfil;

 void _signUpOnPressed()async{


  if(_signUpKey.currentState!.validate()){
    _signUpKey.currentState!.save();
    if(uint8list == null){
      GlobalMethod.showErrorDialog("please provide image", context);
    }



  }

    setState(() {
    _isLoading = true;
  });

try {
  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.toLowerCase().trim(),
  
   password: password.trim());

Reference reference =  FirebaseStorage.instance.ref().child("userImages").child(FirebaseAuth.instance.currentUser!.uid.toString()  + ".jpg");

TaskSnapshot ts = await reference.putData(uint8list!);
imageUrl = await ts.ref.getDownloadURL();

// imageUrl = await reference.getDownloadURL();

FirebaseFirestore.instance
.collection("users")
.doc(FirebaseAuth.instance.currentUser!.uid)
.set({

  "id": FirebaseAuth.instance.currentUser!.uid,
  "name": name,
  "email": email,
  "userImage": imageUrl,
  "phoneNumber": phoneNumber,
  "location": companyAddress,
  "createdAt": DateTime.now(),


});


setState(() {
  _isLoading = false;
});
Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()));


  
  

} catch (e) {
  GlobalMethod.showErrorDialog(e.toString(), context);

  setState(() {
    _isLoading = false;
  });
  print(e); 
}

  




 }

 void _getImageFromCamera()async{

XFile? xFile =  await ImagePicker().pickImage(source: ImageSource.camera);
// var imageCameraFilePath = xFile!.path;
// _justCroppedtheImage(imageCameraFilePath);
var converTedByteFile = await xFile!.readAsBytes();
  setState(() {
    uint8list = converTedByteFile;
     
   });

Navigator.pop(context);


 }

  void _getImageFromGallery()async{
   XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
   var converTedByteFile = await xFile!.readAsBytes();
  // var imagePath = xFile!.path;
  //  _justCroppedtheImage(imagePath);

     setState(() {
    uint8list = converTedByteFile;
     
   });


   Navigator.pop(context);
   




  }

  // void _justCroppedtheImage(String pathOfImageFile)async{
  // var cropedImage = await  ImageCropper().cropImage(sourcePath: pathOfImageFile,
  //   maxHeight: 960,
  //   maxWidth: 700,
    
  //   );

  //   if(cropedImage != null){

  //   setState(() {
  //     xfil = File(cropedImage.path);
  //   });

  //   }
    



  // }

  showDiaogOptionForCG(){

    showDialog(
      barrierDismissible: false,
      
      context: context, builder: (context){

      return AlertDialog(

        
        title: Text("Choose from the following options", style: TextStyle(fontFamily: "myCustomFamilySignatra"),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          
          children: [
          InkWell(
            onTap: (() {
              _getImageFromCamera();
              
            }),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Icon(Icons.camera),
              Text("Camera"),
          
            ],),
          ),

          InkWell(
            onTap: () {

              _getImageFromGallery();

              
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Icon(Icons.browse_gallery),
              Text("Gallery"),
            ],),
          ),

          GestureDetector(
            onTap: (){
              Navigator.pop(context);

            },
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Card(
                  elevation: 5,
                  child: Text("Cancel", style: TextStyle(fontSize: 25, 
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),)),
              ],
            )),


        ],),



      );


    });


    

    





  }




  @override
  void initState() { 
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 25));
    _animation = CurvedAnimation(parent: _animationController!, curve: Curves.linear);
    _animation!.addListener(() { 

      setState(() {
        
      });
    });

    _animation!.addStatusListener((status) {

      if(status == AnimationStatus.completed){
        _animationController!.reset();
        _animationController!.forward();

      }

     });

    _animationController!.forward();
    
  }

  @override
void dispose() { 

  _animationController!.dispose();
  super.dispose();
  
}
  @override
  Widget build(BuildContext context) {
    var _sizeWidth = MediaQuery.of(context).size.width;
    var _sizeHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
    
        body: Stack(children: [
          CachedNetworkImage(
          imageUrl: signUpUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          placeholder: (context, url) => Image.asset("myassets/images/wallpaper.jpg",
          fit: BoxFit.cover,
          
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
       ),

       Container(
        color: Colors.black54,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),

        child: ListView(
          children: [
            Form
            
            
            (
             key: _signUpKey , 
              child: Column(
              children: [

                GestureDetector(
                  onTap: () => showDiaogOptionForCG()


                    
                  ,
                  child: Container(
                    width: _sizeWidth * .20,
                    height: _sizeHeight * .20,
                
                    decoration: BoxDecoration(
                      border: Border.all(width: 3.0, color: Color.fromARGB(255, 209, 189, 189)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                
                    child: ClipRRect(borderRadius: BorderRadius.circular(10),
                    
                    
                      
                      child: uint8list==null? Icon(Icons.camera_enhance):
                      Image(
                        image: MemoryImage(uint8list!),
                        fit: BoxFit.fill
                      ),


                //  xfil==null? Icon(Icons.camera_enhance) : 
                //  Image.file(xfil!,

                //  fit: BoxFit.fill,
                //  ),
                 
                 
                  
                 
                 ),
                  ),
                ),
                 SizedBox(height: MediaQuery.of(context).size.height * 0.03,),

                 TextFormField(
                autofocus: true,
    
                validator: ((value) {
                  if(value!.isEmpty) return "This field is missing";
                  else return null;
    
                  
                  
                }),
    
                onSaved: ((newValue) {
                  setState(() {
                    name = newValue!;
                  });
                  
                }),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.name,
                
                
                decoration: InputDecoration(
                  
                  hintText: "Full name/Company name",
                  hintStyle: TextStyle(color: Colors.white),
    
    
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.yellow)),
                  errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  
    
                ),
    
    
              ),
    
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),

              TextFormField(
                autofocus: true,
    
                validator: ((value) {
                  if(value!.isEmpty || !value.contains("@") || !value.contains(".")) return "valid email address";
                  else return null;
    
                  
                  
                }),
    
                onSaved: ((newValue) {
                  setState(() {
                    email = newValue!;
                  });
                  
                }),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                
                
                decoration: InputDecoration(
                  
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.white),
    
    
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.yellow)),
                  errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  
    
                ),
    
    
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),


               TextFormField(
    
                validator: ((value) {
                  if(value!.isEmpty || value.length<7 ) return "Enter valid password";
                  else return null;
    
                  
                  
                }),
    
                onSaved: ((newValue) {
    
                  setState(() {
                    password = newValue!;
                  });
                  
                }),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscureText,
                
                decoration: InputDecoration(
                  
                  hintText: "Password..",
                  hintStyle: TextStyle(color: Colors.white),
                  suffixIcon: GestureDetector(
                    onTap: (() {
                      setState(() {
                        _obscureText = !_obscureText;
                        
                      });
                      
                    }),
                    
                    child: _obscureText?
                     Icon(
                      
                      
                      Icons.visibility_off, color: Colors.black,):
    
    
                       Icon(Icons.visibility, color: Colors.black,),
                      
                      
                      ),
    
    
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.yellow)),
                  errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  
    
                ),
    
    
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),


                TextFormField(
                autofocus: true,
    
                validator: ((value) {
                  if(value!.isEmpty ) return "This value is missing";
                  else return null;
    
                  
                  
                }),
    
                onSaved: ((newValue) {
                  setState(() {
                    phoneNumber = newValue!;
                  });
                  
                }),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.phone,
                
                
                decoration: InputDecoration(
                  
                  hintText: "phone no..",
                  hintStyle: TextStyle(color: Colors.white),
    
    
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.yellow)),
                  errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  
    
                ),
    
    
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),


                TextFormField(
                autofocus: true,
    
                validator: ((value) {
                  if(value!.isEmpty) return "This field is missing";
                  else return null;
    
                  
                  
                }),
    
                onSaved: ((newValue) {
                  setState(() {
                    companyAddress = newValue!;
                  });
                  
                }),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.text,
                
                
                decoration: InputDecoration(
                  
                  hintText: "Company address..",
                  hintStyle: TextStyle(color: Colors.white),
    
    
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.yellow)),
                  errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  
    
                ),
    
    
              ),
               SizedBox(height: MediaQuery.of(context).size.height * 0.03,),

              Container(
                decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                  
                  


                ),
             
                width: double.infinity,
                child: MaterialButton(
                  elevation: 2.0,
                 
                  onPressed: () {
                    _signUpOnPressed();

                  } 
                  
                ,

                child: _isLoading?Center(

                  child: SizedBox(
                    height: 30.0,
                    width: 30.0,
                    
                    child: CircularProgressIndicator())): SizedBox(
                      height: 40,
                      
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Sign Up",textAlign: TextAlign.center,),
                        ],
                      )),

                
                
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),

              RichText(text: TextSpan(
                children: [
                  TextSpan(
                    text: "Already sign up?",
                    style: TextStyle(color: Colors.white)
                    
                    ),
                    
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                    ..onTap=() {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()));
                      
                    },
                    text: " Log in",
                    style: TextStyle(fontFamily: "myCustomFamilySignatra", color: Colors.white,
                    fontWeight: FontWeight.bold),
              
                    
              
              
                  ),
              
                ]
              
              
              )),



              ],
            )),
           



          ],

        ),

       )
    
    
        ]),
    
    
      ),
    );
  }
}