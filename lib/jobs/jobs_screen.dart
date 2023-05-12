

import 'package:flutter/material.dart';
import 'package:freelanceapp_like_fiverr/widgets/bottom_navigation_screen.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  @override
  Widget build(BuildContext context) {
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
        body: Text("hello"),

        bottomNavigationBar: CurveTypeBottomNavigation(index_no: 0,),
      ),

    );
  }
}