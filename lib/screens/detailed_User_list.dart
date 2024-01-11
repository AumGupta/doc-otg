import 'package:docotg/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../resources/firebase_methods.dart';
import '../utils/utils.dart';

class UserDetailedPage extends StatefulWidget {
  final snap;
  const UserDetailedPage({super.key, this.snap});

  @override
  State<UserDetailedPage> createState() => _UserDetailedPageState();
}

class _UserDetailedPageState extends State<UserDetailedPage> {
  bool isLoading = false;
  void SelectDoc() async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FireStoreMethods().updateDoctor(
          widget.snap['uid'],context);
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar('Selected Successfully', context);
        
      } else {
        setState(() {
          isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(err.toString(), context);
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(width*0.07),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: width*0.8,
                      height: height*0.35,
        
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: NetworkImage(widget.snap['photoUrl']),
                            fit: BoxFit.cover,
                          ),
                          ),
                          // child: ClipRRect(
                          //   borderRadius: BorderRadius.circular(10.0),
                          //   child: Image.network(photourl,width: double.infinity,height: height*0.2,),
                          // ),
                    ),
                  )     ,
                  SizedBox(height: height*0.08,),
                    const Text("Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    SizedBox(height: height*0.02,),
                    Row(
                      children: [
                        Expanded(child: TextFormField(
                          readOnly: true,
                         
                          
                          decoration:  InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                        
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                width: 3, color: Colors.greenAccent),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical:15,horizontal: 20),
                        hintText: widget.snap['fname'].toUpperCase(),
                        hintStyle: const TextStyle(color: Color(0xFFacb1c8))
                        ))),
                       const SizedBox(width: 9,),
                        Expanded(child: TextFormField(
                          
                           
                          decoration:  InputDecoration(
                         border: const OutlineInputBorder(
                          borderSide: BorderSide(
                width: 3, color: Colors.greenAccent),
                        ),
                         fillColor: Colors.white,
                          filled: true,
                        contentPadding: const EdgeInsets.symmetric(vertical:15,horizontal: 20),
                        hintText: widget.snap['lname'].toUpperCase(),
                        hintStyle: const TextStyle(color: Color(0xFFacb1c8))
                        )))
                      ],
                    ),
                     SizedBox(height: height*0.02,),
                    const Text("Age",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    SizedBox(height: height*0.01,),
                    Row(
                      children: [
                        GestureDetector(
                        
                          child: CircleAvatar(
                            radius: width*0.06,
                            backgroundColor: lightGreenColor,
                            child: Icon(Icons.remove,color: greenColor,),
                          ),
                        ),
                        const SizedBox(width: 15,),
                        Container(
                          width: width*0.29,
                          height: height*0.06,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                          child: Center(child: Text("${widget.snap['age']}")),
                        ),
                        const SizedBox(width: 15,),
                         GestureDetector(
                         
                           child: CircleAvatar(
                            radius: width*0.06,
                            backgroundColor: lightGreenColor,
                            child: Icon(Icons.add,color: greenColor,),
                                               ),
                         ),
                      ],
                    ),
                     SizedBox(height: height*0.02,),
                    const Text("Gender",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    SizedBox(height: height*0.01,),
                     Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                              border: Border.all(width: 0, color: Colors.grey),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextFormField(
                          readOnly: true,
                         
                          
                          decoration:  InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                        
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                width: 3, color: Colors.greenAccent),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical:15,horizontal: 20),
                        hintText: widget.snap['gender'],
                        hintStyle: const TextStyle(color: Color(0xFFacb1c8))
                        ))
                        ),
                          SizedBox(height: height*0.02,),
                    const Text("Nationality",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    SizedBox(height: height*0.01,),
                    TextFormField(
                     readOnly: true,
                          decoration:  InputDecoration(
                         border: const OutlineInputBorder(
                          borderSide: BorderSide(
                width: 3, color: Colors.greenAccent),
                        ),
                         fillColor: Colors.white,
                          filled: true,
                        contentPadding: const EdgeInsets.symmetric(vertical:15,horizontal: 20),
                        hintText: widget.snap['nationality'],
                        hintStyle: const TextStyle(color: Color(0xFFacb1c8))
                        )),
                         SizedBox(height: height*0.02,),
                    const Text("Phone Number",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    SizedBox(height: height*0.01,),
                    TextFormField(
                     
                      readOnly: true,
                          decoration:  InputDecoration(
                         border: const OutlineInputBorder(
                          borderSide: BorderSide(
                width: 3, color: Colors.greenAccent),
                        ),
                         fillColor: Colors.white,
                          filled: true,
                        contentPadding: const EdgeInsets.symmetric(vertical:15,horizontal: 20),
                        hintText: widget.snap['number'],
                        hintStyle: const TextStyle(color: Color(0xFFacb1c8))
                        )),
        
                        SizedBox(height: height*0.05,),
                        Center(child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(200, 40), backgroundColor: lightGreenColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: () async {
                                SelectDoc();
                              },
                              child:  Text("Select Doctor",style: TextStyle(color: greenColor,fontSize: 18,fontWeight: FontWeight.bold))))
                      
        
        
                ],
              ),
          ),
        ),
      ),
    );
  }
}
