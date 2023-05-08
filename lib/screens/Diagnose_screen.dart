import 'dart:typed_data';

import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:docotg/resources/firebase_methods.dart';
import 'package:docotg/screens/mobile_screen_layout.dart';
import 'package:docotg/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../provider/user_provider.dart';
import '../utils/utils.dart';

class DiagnoseScreen extends StatefulWidget {
  const DiagnoseScreen({super.key});

  @override
  State<DiagnoseScreen> createState() => _DiagnoseScreenState();
}

class _DiagnoseScreenState extends State<DiagnoseScreen> {
  int tag = 1;
  List<String> tags =[];
  List<String> options = [
    'Fatigue',
    'Sore Throat',
    'Fever below 100°',
    'Fever above 100°',
    'Head ache',
    'Loss of smell',
    'Body pain'
  ];
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool isLoading = false;
_selectImage(BuildContext context)async{
  Size size = MediaQuery.of(context).size;
  return showDialog(context: context, builder: (context){
   return SimpleDialog(
            title: const Text("Create a post"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Take a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState() {
                    _file = file;
                  }
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Choose from photos"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Cancel"),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
  });

}
void postImage(
    String uid,
    String name,
    String profImage,
  ) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FireStoreMethods().uploadPost(
          tags, _file!, uid, name, profImage,context,_descriptionController.text.isEmpty?"no other symptom":_descriptionController.text);
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar('Submitted Successfully', context);
        clearImage();
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

 void clearImage() {
    setState(() {
      _file = null;
    });
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final user user1 = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: ScreenbgColor,
      appBar: AppBar( 
         elevation: 0,
        backgroundColor: secondaryColor,
        automaticallyImplyLeading: false,
        title: Text("DOC-OTG",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
        centerTitle: true,
        actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.menu,color: Colors.black,))
      ]),
      body: Padding(padding: EdgeInsets.all(width*0.08),
      child: SingleChildScrollView(  
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Clinical Inputs",style: TextStyle(fontSize: height*0.044,fontWeight: FontWeight.w500),),
              SizedBox(height: height*0.015,),
            Text("Please share your ,symptoms for diagnosis!",style: TextStyle(color: secondaryTextcolor,fontSize: 15),), 
            SizedBox(height: height*0.03,),
            Text("Clinical Text",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),), 
            SizedBox(height: height*0.01,),
            ChipsChoice<String>.multiple(value: tags, onChanged: (val) => setState(() {
              tags = val;
            }),
            choiceItems: C2Choice.listFrom(source: options, value: (i,v) => v, label: (i,v)=> v),
            choiceActiveStyle: C2ChoiceStyle(color: blueColor,
            borderColor: darkgreenColor,
            borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            choiceStyle:  C2ChoiceStyle(color: Colors.black,
            
            borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            wrapped: true,
            textDirection: TextDirection.ltr,
            
            ),
            Container(
              width: double.infinity,
                height: height*0.12,
                decoration: BoxDecoration(
                   border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white
                 ),
                 child:TextFormField(
                  controller: _descriptionController,
                  maxLength: 200,
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                    label: Text("Other Information"),
                     
                  ),
                 )
            ),
             SizedBox(height: height*0.03,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Image",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.normal),),
               _file!=null? IconButton(onPressed: (){clearImage();}, icon: Icon(Icons.cancel)):SizedBox()
              ],
            ), 
            SizedBox(height: height*0.01,),
            GestureDetector(
              onTap: ()=>_selectImage(context),
              child: Container(
                 width: double.infinity,
                  height: _file!=null?height * 0.35:height*0.15,
                  decoration: BoxDecoration(
                     border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(30),
                            color: secondaryColor
                   ),
                   child: _file!=null? ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                     child: Image(
                                     image: MemoryImage(_file!),
                                     width: double.infinity,
                                     height: height * 0.35,
                                     fit: BoxFit.cover,
                                   ),
                   ) :Center(child: Icon(Icons.camera_alt,color: Colors.grey,size: width*0.2,)),
              ),
            ),
             SizedBox(height: height*0.03,),
            Text("Voice",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),), 
            SizedBox(height: height*0.01,),
            Container(
               width: double.infinity,
                height: height*0.15,
                decoration: BoxDecoration(
                   border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                          color: secondaryColor
                 ),
                 child: Center(child: Icon(Icons.mic,color: Colors.grey,size: width*0.2,)),
            ),
             SizedBox(height: height*0.03,),
            Text("Video",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),), 
            SizedBox(height: height*0.01,),
            Container(
               width: double.infinity,
                height: height*0.15,
                decoration: BoxDecoration(
                   border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                          color: secondaryColor
                 ),
                 child: Center(child: Icon(Icons.video_call,color: Colors.grey,size: width*0.2,)),
            ),
            SizedBox(height: height*0.03,),
            GestureDetector(
              onTap: () async{
                postImage(user1.uid, user1.fname, user1.photoUrl);
                // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> MobileScreenLayout()));
                
              },
              child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0xff585ce5)
                                            ),
                                          child: isLoading ?Center(child: CircularProgressIndicator(),): Center(child: Text("Submit")),
                                            ),
            )



        ]),
      ),
      
      ),
    );
  }
}