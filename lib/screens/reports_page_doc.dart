

import 'package:docotg/utils/colors.dart';
import 'package:flutter/material.dart';

class ReportsPAgeDoc extends StatefulWidget {
  const ReportsPAgeDoc({super.key});

  @override
  State<ReportsPAgeDoc> createState() => _ReportsPAgeDocState();
}

class _ReportsPAgeDocState extends State<ReportsPAgeDoc> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
       backgroundColor: const Color(0xFFfafbff),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFfafbff),
        actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.menu,color: Colors.black,))
      ]),
      body: Padding(  
        padding: EdgeInsets.all(width*0.05),
        child: SingleChildScrollView(  
          child: 
          Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
              Text("Reports",style: TextStyle(fontSize: height*0.049,fontWeight: FontWeight.bold),),
              SizedBox(height: height*0.02,), 
              Text("Pending reports",style: TextStyle(color: secondaryTextColor,fontSize: 16),),
              SizedBox(height: height*0.05,),
              Container(
                height: height*0.16,
                width: double.infinity,
                decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: blueTint
                                            ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      
                      Text("COVID-19",style: TextStyle(color: primaryColor,fontSize: 17,fontWeight: FontWeight.bold),),
                      Icon(Icons.arrow_forward_sharp,color: primaryColor,),
                      Text("Pending",style: TextStyle(color: primaryColor,fontSize: 17,fontWeight: FontWeight.bold),),
                      Icon(Icons.timer_sharp,color: primaryColor,),
                      
                    ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                Container(
                          width: width*0.8,
                          height: height*0.062,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff585be4)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                            Text("Validate  ",style: TextStyle(fontSize: 18,color: Colors.white),),
                            Icon(Icons.arrow_forward_sharp,color: Colors.white,)
                          ]),
                          ),
                  ],
                ),
              ),
               SizedBox(height: height*0.05,),
              Container(
                height: height*0.16,
                width: double.infinity,
                decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: blueTint
                                            ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      
                      Text("COVID-19",style: TextStyle(color: primaryColor,fontSize: 17,fontWeight: FontWeight.bold),),
                      Icon(Icons.arrow_forward_sharp,color: primaryColor,),
                      Text("Pending",style: TextStyle(color: primaryColor,fontSize: 17,fontWeight: FontWeight.bold),),
                      Icon(Icons.timer_sharp,color: primaryColor,),
                      
                    ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                Container(
                          width: width*0.8,
                          height: height*0.062,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff585be4)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                            Text("Validate  ",style: TextStyle(fontSize: 18,color: Colors.white),),
                            Icon(Icons.arrow_forward_sharp,color: Colors.white,)
                          ]),
                          ),
                  ],
                ),
              ),
              SizedBox(height: height*0.02,),
              Text("Validated reports",style: TextStyle(color: secondaryTextColor,fontSize: 16),),
              SizedBox(height: height*0.03,),
               Container(
                height: height*0.16,
                width: double.infinity,
                decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: lightGreenColor
                                            ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      
                      Text("COVID-19",style: TextStyle(color: greenColor,fontSize: 17,fontWeight: FontWeight.bold),),
                      Icon(Icons.arrow_forward_sharp,color: greenColor,),
                      Text("Negative",style: TextStyle(color: greenColor,fontSize: 17,fontWeight: FontWeight.bold),),
                      Icon(Icons.verified,color: greenColor,),
                      
                    ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                Container(
                          width: width*0.8,
                          height: height*0.062,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffbce6e2)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_month,color: greenColor,),

                            Text("   02 July 2022, 09:42 pm ",style: TextStyle(fontSize: 18,color: greenColor),),
                            
                          ]),
                          ),
                  ],
                ),
              ),
                SizedBox(height: height*0.05,),
              Container(
                height: height*0.16,
                width: double.infinity,
                decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: lightGreenColor
                                            ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      
                      Text("COVID-19",style: TextStyle(color: greenColor,fontSize: 17,fontWeight: FontWeight.bold),),
                      Icon(Icons.arrow_forward_sharp,color: greenColor,),
                      Text("Negative",style: TextStyle(color: greenColor,fontSize: 17,fontWeight: FontWeight.bold),),
                      Icon(Icons.verified,color: greenColor,),
                      
                    ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                Container(
                          width: width*0.8,
                          height: height*0.062,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffbce6e2)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_month,color: greenColor,),

                            Text("   24 june 2022, 07:42 pm ",style: TextStyle(fontSize: 18,color: greenColor),),
                            
                          ]),
                          ),
                          
                  ],
                ),
              ),
              SizedBox(
                  height: height*0.05,
                ),
              Container(
                height: height*0.16,
                width: double.infinity,
                decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xfff4c6d1)
                                            ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      
                      Text("COVID-19",style: TextStyle(color: Colors.red,fontSize: 17,fontWeight: FontWeight.bold),),
                      Icon(Icons.arrow_forward_sharp,color: Colors.red,),
                      Text("Positive",style: TextStyle(color: Colors.red,fontSize: 17,fontWeight: FontWeight.bold),),
                      Icon(Icons.warning_amber,color: Colors.red,),
                      
                    ],
                ),
                SizedBox(
                  height: height*0.015,
                ),
                Container(
                          width: width*0.8,
                          height: height*0.062,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffe3b1cb)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.calendar_month,color: Colors.red,),

                            Text("   02 July 2022, 09:42 pm ",style: TextStyle(fontSize: 18,color: Colors.red),),
                            
                          ]),
                          ),
                  ],
                ),
              ),
             ],
          ),
        ),
      ),
    );
    
  }
}