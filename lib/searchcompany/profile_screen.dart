
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:freelanceapp_like_fiverr/services/global_methods.dart';
import 'package:freelanceapp_like_fiverr/user_state.dart';
import 'package:freelanceapp_like_fiverr/widgets/bottom_navigation_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfileCompany extends StatefulWidget {
  String specificId;
  ProfileCompany({super.key, required this.specificId});

  @override
  State<ProfileCompany> createState() => _ProfileCompanyState();
}

class _ProfileCompanyState extends State<ProfileCompany> {
  String? name;
  String imageUrl = "";
  String email = "";
  String joinOrCreateDate = "";
  String phoneNumber = "";


  getUserData()async{
    try {
      DocumentSnapshot userDataDoc = await FirebaseFirestore.instance
    .collection("users")
    .doc(widget.specificId)
    .get();
    if(userDataDoc == null) return;
    //else
    name = userDataDoc.get("name");
    imageUrl = userDataDoc.get("userImage");
    email = userDataDoc.get("email");
    phoneNumber = userDataDoc.get("phoneNumber");
    Timestamp timestamp = userDataDoc.get("createdAt");

    var craeatedDateIn_DateTimeType = timestamp.toDate();

    joinOrCreateDate = "${craeatedDateIn_DateTimeType.year} -${craeatedDateIn_DateTimeType.month}-${craeatedDateIn_DateTimeType.day}"; 


    setState(() {
      
    });



    } catch (e) {
      GlobalMethod.showErrorDialog(e.toString(), context);
    }
  



  }

  @override
  void initState() { 
    super.initState();
    getUserData();
    
  }

  Widget _accountInformation(IconData myIcon, String contnet){

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(myIcon),
          Text(contnet)

        ],

      ),
    );


  }

  Widget _contactBy({required Color color, required IconData icon, required Function function}){


    return CircleAvatar(
      radius: 25,
      backgroundColor: color,

      child: CircleAvatar(radius: 23,
      backgroundColor: color,

      child: IconButton(onPressed: (){
        function();


      }, icon: Icon(icon),
      ),
      
      ),


    );



  }


  _openEmailUrlLauncher()async{

  Uri uri = Uri(scheme: "mailto",
    path: email,
    query: "subject=flutter intern&body= I want this job"
    
    
    );

    launchUrlString(uri.toString());

   


  }
  _openMobilePhoneNoInPhone()async{
    //Parsing means to make something understandable(converting program to internal format) so that runtime environment can run

   Uri uri = Uri.parse("tel: $phoneNumber");
   canLaunchUrl(uri);
  //  launchUrl(uri);







  }

  _openWhatsAppUrlLauncher()async{
    // uiversal link for whatsapp https://wa.me/phonenumber

    Uri uri = Uri.parse("https://wa.me/$phoneNumber");
    launchUrl(uri);
    




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
  bottomNavigationBar: CurveTypeBottomNavigation(index_no: 3,),
  backgroundColor: Colors.black.withOpacity(0),

  body: SingleChildScrollView(
    child: Container(
      margin: EdgeInsets.only(top: 60.0),
      child: Stack(children: [
        Center(
          child: SizedBox(
            height: 300,
            width: 400,
            child: Card(
              
              color: Colors.black45,


              
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
             
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                

                Text(name?? ""),

                
                    SizedBox(height: 15,),
                
                Container(
                  margin: EdgeInsets.only(left: 50, right: 50),
                  child: Divider(thickness: 2,
                  color: Colors.white,),
                ),

                SizedBox(height: 15,),

                Text("Account information:"),
                _accountInformation(Icons.email, email),
                _accountInformation(Icons.phone, phoneNumber),
                  Container(
                    margin: EdgeInsets.only(left: 50, right: 50),
                    child: Divider(thickness: 2,
                color: Colors.white,),
                  ),

              FirebaseAuth.instance.currentUser!.uid == widget.specificId?
              Container() : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                
                children: [

                _contactBy(color: Colors.red
                , icon: Icons.phone, function: (){
                  _openMobilePhoneNoInPhone();

                }),

                _contactBy(color: Colors.black , icon: FontAwesome.whatsapp, function: (){
                  _openWhatsAppUrlLauncher();

                }),

                _contactBy(color: Colors.yellow
                , icon: Icons.email, function:(){
                  _openEmailUrlLauncher();


                })




              ],) ,  

               FirebaseAuth.instance.currentUser!.uid == widget.specificId?

               Center(
                 child: MaterialButton(
                  child: Card(
                    color: Colors.black,
                    
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Log out", style: TextStyle(color: Colors.white),),
                        Icon(Icons.logout, color: Colors.white,),

                      ],
                  ),
                    ),),
                  
                  
                  onPressed: (()async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserState()));

                  
                   
                 }
                 
                 
                 )),
               ): Container(



               )




              ],



            ),
          ),
        ),


        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                    height: 40,
                    width: 40,

                    decoration: BoxDecoration(
                      border: Border.all(width: 5,
                      color: Colors.red),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        
                        image: NetworkImage(imageUrl))

                    ),

                  ),




            ],),
        )
          


      ]),
    ),


  )
 





  
 ),
  
    );
  }
}