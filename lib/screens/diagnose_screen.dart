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
  // Name of the options should be same as text model variables with "_" replaced with " "
  List<String> options = [
    "Cough",
    "Fever",
    "Sore Throat",
    "Shortness of Breath",
    "Headache",
    "Old Age",
    "Contact",
  ];
  Map<String,String> symptoms = {};
  // Helps in making Tags (list of symptoms ) into a Map of Symptoms (A format needed by Text Analysis model)
  void mapSymptoms(Map<String,String> symptoms, List<String> tags) {
    for(var i=0;i<tags.length;i++){
      var key = tags[i].toLowerCase().replaceAll(" ", "_");
      var value = symptoms[key];
      symptoms[key] = "True";
    }
  }


  //Image File
  Uint8List? _imageFile;
  final TextEditingController _descriptionController = TextEditingController();
  bool isLoading = false;
  //Audio FIle
  String? _audioFilePath;
  AudioPlayer? player;
  bool isPlaying = false;

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
                _imageFile = file;
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
                _imageFile = file;
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

  void clearImage() {
    setState(() {
      _imageFile = null;
    });
  }
  void clearAudio() {
    player?.stop();
    setState(() {
      _audioFilePath = null;
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
          symptoms, _imageFile!, uid, name, profImage,_audioFilePath!,context,_descriptionController.text.isEmpty?"no other symptom":_descriptionController.text);
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
      String res2 = await FireStoreMethods().uploadReport(uid, symptoms);
      if (res2 == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar('Validated Successfully', context);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(err.toString(), context);
    } finally {
      setState(() {
        tags = [];
      });
      player?.dispose();
      _descriptionController.clear();
    }
  }


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


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final user user1 = Provider.of<UserProvider>(context).getUser;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragCancel: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: screenBgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width*0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Please share your symptoms for diagnosis!",style: TextStyle(color: greyColor,fontSize: 15),),
                SizedBox(height: height*0.03,),
                Text("Symptoms",style: TextStyle(color: darkPurple,fontSize: 15,fontWeight: FontWeight.bold),),
                SizedBox(height: height*0.01,),

                // Symptoms Selector
                ChipsChoice<String>.multiple(value: tags, onChanged: (val) => setState(() {
                  symptoms = {
                    "cough": "False",
                    "fever": "False",
                    "sore_throat": "False",
                    "shortness_of_breath": "False",
                    "headache": "False",
                    "old_age": "False",
                    "contact": "False"
                  };
                  tags = val;
                  mapSymptoms(symptoms,tags);
                }),
                  choiceItems: C2Choice.listFrom(
                      source: options,
                      value: (i,v) => v,
                      label: (i,v)=> v),
                      choiceActiveStyle: C2ChoiceStyle(color: Colors.white,
                      backgroundColor: primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(30))
                      ),
                  choiceStyle:  C2ChoiceStyle(
                      color: darkPurple,
                      backgroundColor: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(30))
                  ),
                  wrapped: true,
                  textDirection: TextDirection.ltr,
                ),

                Container(
                    width: double.infinity,
                    height: height*0.15,
                    decoration: BoxDecoration(
                       // border: Border.all(width: 1, color: greyColor),
                      borderRadius: BorderRadius.circular(30),
                      color: blueTint,
                    ),
                    child:TextFormField(
                      controller: _descriptionController,
                      maxLength: 200,
                      maxLines: 3,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                        hintText: "Other Symptoms",
                      ),
                     )
                ),
                SizedBox(height: height*0.03,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Image", style: TextStyle(color: darkPurple,fontSize: 15,fontWeight: FontWeight.bold),),
                    _imageFile!=null ? IconButton(onPressed: (){clearImage();},
                        icon: Icon(Icons.cancel, color: greyColor,)) : const SizedBox()
                  ],
                ),
                SizedBox(height: height*0.01,),
                GestureDetector(
                  onTap: ()=>_selectImage(context),
                  child: Container(
                     width: double.infinity,
                      height: _imageFile!=null?height * 0.35:height*0.15,
                      decoration: BoxDecoration(
                        // border: Border.all(width: 1, color: greyColor),
                        borderRadius: BorderRadius.circular(30),
                        color: blueTint,
                      ),
                       child: _imageFile!=null? ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                         child: Image(
                                         image: MemoryImage(_imageFile!),
                                         width: double.infinity,
                                         height: height * 0.35,
                                         fit: BoxFit.cover,
                                       ),
                       ) :Center(child: Icon(Icons.add_a_photo_outlined,color: greyColor,size: width*0.15,)),
                  ),
                ),

                //Voice Input
                SizedBox(height: height*0.03,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Voice",style: TextStyle(
                        color: darkPurple,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),),
                    _audioFilePath!=null? IconButton(
                        onPressed: (){
                          clearAudio();
                          },
                        icon: Icon(Icons.cancel, color: greyColor,)) : const SizedBox()
                  ],
                ),
                SizedBox(height: height*0.01,),
                GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   player = AudioPlayer();
                    // });
                    _selectVoice(context);
                    },
                  child: Container(
                    width: double.infinity,
                    height: height*0.15,
                    decoration: BoxDecoration(
                      // border: Border.all(width: 1, color: greyColor),
                      borderRadius: BorderRadius.circular(30),
                      color: blueTint,
                    ),
                    child: _audioFilePath!=null? ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: IconButton(
                        icon: Icon(isPlaying?Icons.pause_circle:Icons.play_circle,color: primaryColor,size: width*0.2,),
                        onPressed: () async {
                          isPlaying ? await player?.pause() : await player?.play(DeviceFileSource(_audioFilePath!));
                        },
                      ),

                    ) :Center(child: Icon(Icons.multitrack_audio_rounded,color: greyColor,size: width*0.15,)),
                  ),
                ),

                // Video Input
                SizedBox(height: height*0.03,),
                Text("Video",style: TextStyle(color: darkPurple,fontSize: 15,fontWeight: FontWeight.bold),),
                SizedBox(height: height*0.01,),
                Container(
                   width: double.infinity,
                    height: height*0.15,
                    decoration: BoxDecoration(
                      // border: Border.all(width: 1, color: greyColor),
                      borderRadius: BorderRadius.circular(30),
                      color: blueTint,
                    ),
                     child: Center(child: Icon(Icons.video_call_outlined,color: greyColor,size: width*0.15,)),
                ),
                SizedBox(height: height*0.03,),

                // Submit
                GestureDetector(
                  onTap: () async{
                    submitInputs(user1.uid, user1.fname, user1.photoUrl);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        boxShadow: const [BoxShadow(color:Color(0x90585be4), blurRadius: 20),],
                        borderRadius: BorderRadius.circular(50),
                        color: primaryColor,
                    ),
                    child: isLoading ? const Center(
                      child: CircularProgressIndicator( color: Colors.white, strokeWidth: 2,),) : Row (mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: const [Text("Diagnose ",
                                                                                          style: TextStyle(
                                                                                          color: Colors.white,
                                                                                          fontSize: 15,),
                                                                                    ),
                                                                                    Icon(Icons.arrow_forward_sharp, size: 20.0, color: Colors.white, weight: 100,)
                        ],
                      ),
                  ),
                ),
                SizedBox(height: height*0.1,),
              ]),
          ),
        ),
      ),
    );
  }
}