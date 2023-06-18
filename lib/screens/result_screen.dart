import 'package:docotg/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../provider/user_provider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final user user1 = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: screenBgColor,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        },icon:const Icon(Icons.arrow_back_ios_outlined,color: Colors.black,)),
        actions: [

        IconButton(onPressed: (){}, icon: const Icon(Icons.menu,color: Colors.black,))
      ]),
      backgroundColor: screenBgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width*0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Result",style: TextStyle(fontSize: height*0.044,fontWeight: FontWeight.w500),),
                  SizedBox(height: height*0.015,),
              Text("Post analysis Report",style: TextStyle(color: secondaryTextColor,fontSize: 15),),
              SizedBox(height: height*0.03,),
              Container(
                height: height*0.54,
                width: double.infinity,
                decoration: BoxDecoration(color: const Color(0xFFecf2ff),
                border: Border.all(width: 1, color: Colors.transparent),
                          borderRadius: BorderRadius.circular(35),
                          
                 ),
                 child: Padding(
                   padding: EdgeInsets.all(width*0.07),
                   child: Column(
                    children: [
                    CircleAvatar(
                      radius: width*0.14,
                      backgroundColor: lightGreenColor,
                      child: Icon(Icons.verified,color: greenColor,size: width*0.14,),),
                      SizedBox(height: height*0.025,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Name:",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22,color: Colors.black),),
                            SizedBox(height: height*0.025,),
                            const Text("Disease:",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22,color: Colors.black),),
                            SizedBox(height: height*0.025,),
                            const Text("Result:",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22,color: Colors.black),),
                            SizedBox(height: height*0.025,),
                            const Text("Date:",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22,color: Colors.black),),
                            SizedBox(height: height*0.025,),
                            const Text("Time:",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22,color: Colors.black),),
                            SizedBox(height: height*0.025,),
                           
      
                          ],
                        ),
                      
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 2,),
                            Text(user1.fname,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 21,color: Colors.black),),
                            SizedBox(height: height*0.025,),
                            const Text("COVID-19",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 21,color: Colors.black),),
                            SizedBox(height: height*0.025,),
                            const Text("Negative",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 21,color: Colors.black),),
                            SizedBox(height: height*0.025,),
                            const Text("23-Jan-2022",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 21,color: Colors.black),),
                            SizedBox(height: height*0.025,),
                            const Text("09:30 p.m",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 21,color: Colors.black),),
                            SizedBox(height: height*0.025,),
                            
      
                          ],
                        ),
                  ],
                ),
                   ]),
                 ),
                ),
                SizedBox(height: height*0.025,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                                            width: width*0.4,
                                            height: 50,
                                            decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 1, color: Colors.black26),
                          
                         
                          color: Colors.white
                                            ),
                                          child: Center(child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: const [
                                              Text("Download"),
                                              Icon(Icons.download)
                                            ],
                                          )),
                                            ),
                    Container(
                                            width: width*0.4,
                                            height: 50,
                                            decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color(0xff585ce5)
                                            ),
                                          child: Center(child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: const [
                                              Text("Share"),
                                              Icon(Icons.share)
                                            ],
                                          )),
                                            ),
                  ],
                )

                
              
      
            ],
      
          ),
        ),
      ),
    );
  }
}