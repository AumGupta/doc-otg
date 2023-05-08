import 'package:docotg/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: bgcolor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Image.asset("assets/Logo.png",height: width*0.65,),
             Text("Doctor On-The-Go",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
             SizedBox(height: height*0.08,),
             CircleAvatar(
              radius: width*0.092,
              backgroundColor: secondaryTextcolor,
               child: CircleAvatar(
                radius: width*0.09,
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_forward_ios),
               ),
             ),
             SizedBox(height: height*0.18,),
             Text("Project by the Computer Science",style: TextStyle(color: secondaryTextcolor,fontSize: 16),),
             Text("Department,SGGSCC",style: TextStyle(color: secondaryTextcolor,fontSize: 16),),
                   
            
          ],
        ),
      ),
    );
  }
}