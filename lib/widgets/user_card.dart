

import 'package:docotg/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserPostCard extends StatefulWidget {
  final snap;
  const UserPostCard({super.key, this.snap});

  @override
  State<UserPostCard> createState() => _UserPostCardState();
}

class _UserPostCardState extends State<UserPostCard> {
  
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            height: height*0.29,
            width: width*0.429,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: secondaryColor
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(widget.snap['photoUrl'],width: width*0.4,height: height*0.23,fit: BoxFit.cover,)),
                    const SizedBox(height: 5,),
                  Text(widget.snap['fname'].toString(),style: const TextStyle(fontWeight: FontWeight.w500),)
                ]),
              ),
          
          )
        ],
      ),

    );
  }
}