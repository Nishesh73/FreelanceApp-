
import 'package:flutter/material.dart';
import 'package:freelanceapp_like_fiverr/widgets/bottom_navigation_screen.dart';

class ProfileCompany extends StatefulWidget {
  const ProfileCompany({super.key});

  @override
  State<ProfileCompany> createState() => _ProfileCompanyState();
}

class _ProfileCompanyState extends State<ProfileCompany> {
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
  appBar: AppBar(title: Text("Profile Screen"),
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
  
 ),
  
    );
  }
}