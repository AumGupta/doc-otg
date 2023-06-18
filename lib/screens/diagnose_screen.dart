import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:docotg/resources/firebase_methods.dart';
import 'package:docotg/utils/colors.dart';
import 'package:flutter/material.dart';
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
    "Cough",
    "Fever",
    "Sore Throat",
    "Shortness of Breath",
    "Headache",
    "Old Age",
    "Contact",
    // 'Fatigue',
    // 'Sore Throat',
    // 'Fever below 100°',
    // 'Fever above 100°',
    // 'Head ache',
    // 'Loss of smell',
    // 'Body pain'
  ];

  //Image File
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool isLoading = false;
  //Audio FIle
  String? _audioFilePath;
  AudioPlayer? player;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      player = AudioPlayer();
    });
    player?.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
  }
// Image Selection Dialogue Box
_selectImage(BuildContext context)async{
  Size size = MediaQuery.of(context).size;
  return showDialog(context: context, builder: (context){
   return SimpleDialog(
            title: const Text("Select Image",
                              style: TextStyle(fontWeight: FontWeight.bold),),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Take a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
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
_selectVoice(BuildContext context)async{
    Size size = MediaQuery.of(context).size;
    return showDialog(context: context, builder: (context){
      return SimpleDialog(
        title: const Text("Select Voice",
          style: TextStyle(fontWeight: FontWeight.bold),),
        children: [
          // SimpleDialogOption(
          //   padding: const EdgeInsets.all(20),
          //   child: const Text("Record Audio"),
          //   onPressed: () async {
          //     Navigator.of(context).pop();
          //     Uint8List file = await pickImage(ImageSource.camera);
          //   },
          // ),
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text("Choose from files"),
            onPressed: () async {
              Navigator.of(context).pop();
              String file = await pickAudio();
              setState(() {
                _audioFilePath = file;
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

void submitInputs(
    String uid,
    String name,
    String profImage,
  ) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FireStoreMethods().uploadPost(
          tags, _file!, uid, name, profImage,_audioFilePath!,context,_descriptionController.text.isEmpty?"no other symptom":_descriptionController.text);
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar('Submitted Successfully', context);
        clearImage();
        clearAudio();
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
  void clearAudio() {
    setState(() {
      _audioFilePath = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final user user1 = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: screenBgColor,
      appBar: AppBar(
         elevation: 0,
        backgroundColor: blueTint,
        automaticallyImplyLeading: false,
        actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.menu,color: Colors.black,))
      ]),
      body: Padding(padding: EdgeInsets.all(width*0.08),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Clinical Inputs",style: TextStyle(fontSize: height*0.044,fontWeight: FontWeight.w500),),
              SizedBox(height: height*0.015,),
            Text("Please share your ,symptoms for diagnosis!",style: TextStyle(color: secondaryTextColor,fontSize: 15),),
            SizedBox(height: height*0.03,),
            const Text("Clinical Text",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
            SizedBox(height: height*0.01,),
            ChipsChoice<String>.multiple(value: tags, onChanged: (val) => setState(() {
              tags = val;
            }),
            choiceItems: C2Choice.listFrom(source: options, value: (i,v) => v, label: (i,v)=> v),
            choiceActiveStyle: C2ChoiceStyle(color: primaryColor,
            borderColor: greenColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))
            ),
            choiceStyle:  const C2ChoiceStyle(color: Colors.black,

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
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                    label: Text("Other Symptoms"),

                  ),
                 )
            ),
             SizedBox(height: height*0.03,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Image",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.normal),),
               _file!=null? IconButton(onPressed: (){clearImage();}, icon: const Icon(Icons.cancel)):const SizedBox()
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
                            color: blueTint
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Voice",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
                _audioFilePath!=null?IconButton(onPressed: (){clearAudio();}, icon: const Icon(Icons.cancel)):const SizedBox()
              ],
            ),
            SizedBox(height: height*0.01,),
            GestureDetector(
              onTap: ()=>_selectVoice(context),
              child: Container(
                width: double.infinity,
                height: height*0.15,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(30),
                    color: blueTint
                ),
                child: _audioFilePath!=null? ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: IconButton(
                    icon: Icon(isPlaying?Icons.pause_circle:Icons.play_circle,color: primaryColor,size: width*0.2,),
                    onPressed: () async {
                      isPlaying ? await player?.pause() : await player?.play(DeviceFileSource(_audioFilePath!));
                    },
                  ),

                ) :Center(child: Icon(Icons.mic_rounded,color: Colors.grey,size: width*0.2,)),
              ),
            ),
             SizedBox(height: height*0.03,),
            const Text("Video",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
            SizedBox(height: height*0.01,),
            Container(
               width: double.infinity,
                height: height*0.15,
                decoration: BoxDecoration(
                   border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                          color: blueTint
                 ),
                 child: Center(child: Icon(Icons.video_call,color: Colors.grey,size: width*0.2,)),
            ),
            SizedBox(height: height*0.03,),
            GestureDetector(
              onTap: () async{
                submitInputs(user1.uid, user1.fname, user1.photoUrl);
                // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> MobileScreenLayout()));

              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: primaryColor,
                ),
                child: isLoading ? const Center(child: CircularProgressIndicator(),): const Center(child: Text("Submit")),
              ),
            )
          ]),
      ),
      ),
    );
  }
}