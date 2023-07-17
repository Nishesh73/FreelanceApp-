import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelanceapp_like_fiverr/services/global_variable.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController _passwordResetController = TextEditingController();

  // @override
  // void dispose() {
  //   _passwordResetController.dispose();
    
  //   super.dispose();
  // }

  void _resetPassword() async{
    print(_passwordResetController.text);
    try {
     await FirebaseAuth.instance.sendPasswordResetEmail(email: _passwordResetController.text.trim());
     Fluttertoast.showToast(msg: "Check your email to reset password", toastLength: Toast.LENGTH_LONG,
     gravity: ToastGravity.CENTER);
     setState(() {
       _passwordResetController.text = "";
     });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
      print(e); 
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(1),
      // actions: [IconButton(onPressed: (){
      //   Navigator.pop(context);



      // }, icon: Icon(Icons.arrow_back))],
      ),

      body: Stack(children: [
        CachedNetworkImage(
        imageUrl: forgotUrl,
        height: double.infinity,
        fit: BoxFit.fill,
        placeholder: (context, url) => Image.asset("myassets/images/wallpaper.jpg",
        fit: BoxFit.fill,
        
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
     ),

     Container(
      color: Colors.black54,
      child: ListView(
        padding: EdgeInsets.only(top: 50.0, left: 10.0),
        
        children: [
        Text("Forget password", style: TextStyle(fontFamily: "myCustomFamilySignatra",
        fontSize: 50.0 ,color: Colors.white),),

        Text("Email address", style: TextStyle(color: Colors.white, fontSize: 25,
        fontStyle: FontStyle.italic),),

        TextField(
          controller: _passwordResetController,

          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(200, 255, 255, 255),
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color:Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),


          ),
        ),
        SizedBox(height: 10,),

        MaterialButton(onPressed: () {
          _resetPassword();

        } ,
        height: 50,
        color: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        
        child: Text("Reset password", style: TextStyle(color: Colors.white),),
        
        
        )
       


      ],),
     )


      ]),

     
    );
  }
}