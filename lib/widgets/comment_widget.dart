
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelanceapp_like_fiverr/searchcompany/profile_screen.dart';

class CommentWidget extends StatefulWidget {
  String commentTeter;
  String commentBody;
  String commentTeterId;
  String commentImageUrl;
CommentWidget({super.key, required this.commentTeter, required this.commentBody, required this.commentTeterId,

required this.commentImageUrl});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() => Navigator.push(context, MaterialPageRoute(builder: (context) =>
      ProfileCompany(specificId: widget.commentTeterId ,)

      
      ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
    
          Flexible( 
            flex: 1,
            
            child: Container(
              width: 40,
              height: 40,
    
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  
                  
                  image: NetworkImage(widget.commentImageUrl))
    
    
    
              ),
    
            )),
    
            SizedBox(width: 10,),
    
            Flexible(
              flex: 5,
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.commentTeter,
                  style: TextStyle(fontSize: 25,
                  fontFamily: "myCustomFamilySignatra",
                  fontWeight: FontWeight.bold,
                  
                  ),
                  
                  
                  ),
    
                   Text(widget.commentBody,
                  style: TextStyle(fontSize: 20,
               
                  fontWeight: FontWeight.bold,
                  
                  ),
                  
                  
                  ),
    
    
                ],
              ))
    
    
        ],
      ),
    );
  }
}