

import 'package:flutter/material.dart';
import 'package:freelanceapp_like_fiverr/widgets/bottom_navigation_screen.dart';

class SearchCompany extends StatefulWidget {
  const SearchCompany({super.key});

  @override
  State<SearchCompany> createState() => _SearchCompanyState();
}

class _SearchCompanyState extends State<SearchCompany> {
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
  bottomNavigationBar: CurveTypeBottomNavigation(index_no: 1,),
  backgroundColor: Colors.black.withOpacity(0),
  appBar: AppBar(title: Text("All workers screens"),
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