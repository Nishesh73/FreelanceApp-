
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:freelanceapp_like_fiverr/forgetPassword/forget_password.dart';
import 'package:freelanceapp_like_fiverr/jobs/jobs_screen.dart';
import 'package:freelanceapp_like_fiverr/services/global_methods.dart';
import 'package:freelanceapp_like_fiverr/services/global_variable.dart';
import 'package:freelanceapp_like_fiverr/signUp/sign_up_screen.dart';


class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> with TickerProviderStateMixin  {
  Animation? _linearAnimation;
  AnimationController? _animationController;

  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _obscureText = true;

  bool _isLoading = false;


  void _onLogInPress() async{
     if(_formKey.currentState!.validate()){
        _formKey.currentState!.save();
        
       
      } 

    try {

      setState(() {
        _isLoading = true;
      });
     
      
    await  FirebaseAuth.instance.signInWithEmailAndPassword(email: email.toLowerCase().trim(), password: password.trim());


    setState(() {
        _isLoading = false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => JobScreen()));
     


      
    } catch (e) {
       setState(() {
        _isLoading = false;
      });
     
      GlobalMethod.showErrorDialog(e.toString(), context);
      print("Error is here ${e.toString()}"); 
    }

    



  }

  @override
  void dispose() {
    _animationController!.dispose();
    
    super.dispose();
  }

  @override
  void initState() {
    super.initState(); 
   


    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 29));
    _linearAnimation = CurvedAnimation(parent: _animationController!, curve: Curves.linear);

    //to call the build method for update add listener
    _linearAnimation!.addListener(() { 

      setState(() {
        
      });


    });
   
     //animation end, start addstatus listener
    _linearAnimation!.addStatusListener((status) { 

      if(status == AnimationStatus.completed){

        _animationController!.reset();
        _animationController!.forward();
      }



    });

    

    _animationController!.forward();

   

    



    
     


    
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(children: [
          CachedNetworkImage(
            
          imageUrl: showAnimUrl, fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
          // alignment: FractionalOffset(_linearAnimation!.value, 0),
          
          placeholder: (context, url) => Image.asset("myassets/images/wallpaper.jpg",
          fit: BoxFit.cover,
          
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
       ),
    
       Container(
        padding: EdgeInsets.all(8),
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Image.asset("myassets/images/login.png"),
          ),
    
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          Form(
            key: _formKey,
            child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(children: [
    
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
                keyboardType: TextInputType.text,
                
                
                decoration: InputDecoration(
                  
                  hintText: "Email..",
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

              
               SizedBox(height: MediaQuery.of(context).size.height * 0.03),
    
              Align(
                alignment: Alignment.bottomRight,
                
                child: TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword()
                  )),
                  
                  
                  child: Text("Forget password", style: TextStyle(color: Colors.white, fontFamily: "myCustomFamilySignatra", fontStyle: FontStyle.italic, fontSize: 20.0),))),
    
                  const SizedBox(height: 10,),
    
    
              Container(
                width: double.infinity,
                height: 40,
                child: MaterialButton(onPressed: _onLogInPress
                  
                  
               ,
                
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Colors.cyan,
                child: _isLoading?Center(child: CircularProgressIndicator()) : Text("LogIn"),
                
                ),
              ),

              RichText(text: TextSpan(
                children: [
                 TextSpan(
                  style: TextStyle(color: Colors.white),
                  text: "Donot have Account?" 
                 ),

                 TextSpan(
                  style: TextStyle(fontFamily: "myCustomFamilySignatra", color: Colors.white),
                  text: " Sign up",
                  recognizer: TapGestureRecognizer() 
                  ..onTap=(() => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp())) )
                  

                 ),

                ]

              )

              )    
    
    
    
    
              
    
    
            ],),
          )),
    
    
    
        ],),
       ),
    
    
        ]),
    
      ),
    );
  }
}