import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:docotg/screens/video_player.dart';

// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chips_choice/chips_choice.dart';

import 'package:docotg/resources/firebase_methods.dart';
import 'package:docotg/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../provider/user_provider.dart';
import '../utils/utils.dart';

// import 'package:flutter_sound/flutter_sound.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:path_provider/path_provider.dart';

class DiagnoseScreen extends StatefulWidget {
  const DiagnoseScreen({super.key});

  @override
  State<DiagnoseScreen> createState() => _DiagnoseScreenState();
}

class _DiagnoseScreenState extends State<DiagnoseScreen> {
  List<String> tags = [];
  Widget submissionStatus = const SizedBox();

  // Name of the options should be same as text model variables with "_" replaced with " "
  List<String> options = [
    "Cough",
    "Fever",
    "Sore Throat",
    "Shortness of Breath",
    "Headache",
    // "Old Age",
    "Contact",
  ];
  Map<String, String> symptoms = {};

  // Helps in making Tags (list of symptoms ) into a Map of Symptoms (A format needed by Text Analysis model)
  void mapSymptoms(Map<String, String> symptoms, List<String> tags) {
    for (var i = 0; i < tags.length; i++) {
      var key = tags[i].toLowerCase().replaceAll(" ", "_");
      symptoms[key] = "True";
    }
  }

  final TextEditingController _descriptionController = TextEditingController();
  bool isLoading = false;

  //Image File
  Uint8List _imageFile = Uint8List(0);

  //Audio FIle
  String _audioFilePath = '';
  AudioPlayer? player;
  late bool _isAudioPlaying = false;
  late bool _isRecorderRecording = false;

  // Video File
  String _videoFile = '';
  bool isVideoPresent = false;

  // Image Selection Dialogue Box
  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text(
              "Select Image",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
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

  _selectVideo(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text(
              "Select Video",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Record a video"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  String file = await pickVideo(ImageSource.camera);
                  setState(() {
                    _videoFile = file;
                    isVideoPresent = true;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Choose from gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  String file = await pickVideo(ImageSource.gallery);
                  setState(() {
                    _videoFile = file;
                    isVideoPresent = true;
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

  _selectVoice(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text(
              "Select Voice",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Record"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  setState(() {
                    statusText = 'Start Recording';
                  });
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return SimpleDialog(
                            title: const Text(
                              'Record Audio',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            children: [
                              CircleAvatar(
                                radius: 36,
                                backgroundColor: primaryColor,
                                child: IconButton(
                                  icon: Icon(
                                    (RecordMp3.instance.status == RecordStatus.RECORDING)
                                        ? Icons.stop
                                        : Icons.mic,
                                    color: Colors.white,
                                    size: 36,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isRecorderRecording =
                                          !_isRecorderRecording;
                                    });
                                    if (!_isRecorderRecording) {
                                      startRecord();
                                    } else {
                                      stopRecord();
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                  child: Text(
                                statusText!,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  // fontStyle: FontStyle.italic
                                ),
                              )),
                            ],
                          );
                        });
                      });
                  // Navigator.of(context).pop();
                  // String file = await pickAudio();
                  // setState(() {
                  //   _audioFilePath = file;
                  // });
                },
              ),
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
      _imageFile = Uint8List(0);
    });
  }

  void clearAudio() {
    player?.stop();
    setState(() {
      _audioFilePath = '';
    });
  }

  void clearVideo() {
    setState(() {
      _videoFile = '';
      isVideoPresent = false;
    });
  }

  // Future<void> playFunc() async {
  //   player?.open(
  //     Audio.file(_audioFilePath),
  //     autoStart: true,
  //     showNotification: true,
  //   );
  // }

  // Future<void> stopPlayFunc() async {
  //   player?.stop();
  //   // setState(() {
  //   //   _audioFilePath = '';
  //   // });
  // }

  // Audio Recorder

  String? statusText;
  String recordFilePath = '';
  bool isComplete = false;

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Recording...";
      recordFilePath = await getFilePath();
      isComplete = false;
      RecordMp3.instance.start(recordFilePath, (type) {
        statusText = "Record error--->$type";
        setState(() {});
      });
    } else {
      statusText = "No microphone permission";
    }
    setState(() {});
  }

  void pauseRecord() {
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool s = RecordMp3.instance.resume();
      if (s) {
        statusText = "Recording...";
        setState(() {});
      }
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {
        statusText = "Recording pause...";
        setState(() {});
      }
    }
  }

  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      statusText = "";
      isComplete = true;
      _audioFilePath = recordFilePath;
      setState(() {});
    }
  }

  void resumeRecord() {
    bool s = RecordMp3.instance.resume();
    if (s) {
      statusText = "Recording...";
      setState(() {});
    }
  }

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = "${storageDirectory.path}/recordings";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    final dt = DateTime.now();
    return "$sdPath/audio_dated_${dt.day}_${dt.month}_${dt.year}_${dt.hour}_${dt.minute}_${dt.second}.mp3";
  }

  // Future startAppRecorder() async {
  //   await recorder!.startRecorder(
  //     toFile: 'audio',
  //     // toFile: DateTime.now().toString(),
  //   );
  //   // recorder!.openRecorder();
  //   // try {
  //   //   await recorder!.startRecorder(
  //   //     toFile: 'audio.mp3',
  //   //     // toFile: DateTime.now().toString(),
  //   //     codec: Codec.mp3,
  //   //   );
  //   // } catch (e) {
  //   //   await recorder!.startRecorder(
  //   //     toFile: 'audio.mp3',
  //   //     // toFile: DateTime.now().toString(),
  //   //     // codec: Codec.mp3,
  //   //   );
  //   // }
  // }

  // Future stopAppRecorder() async {
  //   final path = await recorder!.stopRecorder();
  //   setState(() {
  //     _audioFilePath = path!;
  //   });
  //   print('************[$_audioFilePath]');
  // }

  // Future initRecorder() async {
  //   final status = await Permission.microphone.request();
  //   if (status != PermissionStatus.granted) {
  //     throw 'Microphone permisson not granted.';
  //   }
  //   recorder!.openRecorder();
  //   recorder!.setSubscriptionDuration(
  //     const Duration(microseconds: 500),
  //   );
  // }

  void submitInputs(
    String uid,
    String name,
    String profImage,
  ) async {
    if (symptoms.values.any((element) => true) == false) {
      showSnackBar("Please enter symptoms to submit", context);
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      setState(() {
        submissionStatus = Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: Text(
              'Submitting...',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                // fontStyle: FontStyle.italic
              ),
            ));
      });
      // Input Submission
      String res = await FireStoreMethods().uploadPost(
          symptoms,
          _imageFile.isNotEmpty ? _imageFile : Uint8List(0),
          uid,
          name,
          profImage,
          _audioFilePath.isNotEmpty ? _audioFilePath : '',
          _videoFile.isNotEmpty ? _videoFile : '',
          context,
          _descriptionController.text.isNotEmpty
              ? _descriptionController.text
              : 'NA');
      if (res == 'success') {
        setState(() {
          submissionStatus = Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: Text(
                'Validating...',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  // fontStyle: FontStyle.italic
                ),
              ));
        });
      }
      print('Post Submitted');
      // Input Analysis
      String res2 = await FireStoreMethods().uploadReport(
        uid: uid,
        symptoms: symptoms,
        image: base64.encode(_imageFile),
      );
      if (res2 == "success") {
        setState(() {
          // submissionStatus = Text('Validated Successfully');
          isLoading = false;
          submissionStatus = const SizedBox();
        });
        showSnackBar('Diagnose Successful', context);
      } else {
        setState(() {
          isLoading = false;
        });
        showSnackBar(res2, context);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
        submissionStatus = const SizedBox();
      });
      showSnackBar(err.toString(), context);
    } finally {
      setState(() {
        tags = [];
        symptoms = {};
        submissionStatus = const SizedBox();
        _descriptionController.text = '';
        clearImage();
        clearAudio();
        clearVideo();
      });
      // player?.dispose();
      _descriptionController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      player = AudioPlayer();
    });
    // if (_videoFile != File('')) {
    // initVideoPlayer(_videoFile);
    //   print("*********************VIDEO PLAYER ON");
    // }
    player?.onPlayerStateChanged.listen((state) {
      setState(() {
        _isAudioPlaying = state == PlayerState.playing;
      });
    });
  }

  @override
  void dispose() {
    // recorder!.di
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final user user1 = Provider.of<UserProvider>(context).getUser;
    String name = '${user1.fname} ${user1.lname}';
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragCancel: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: screenBgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width * 0.075),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Please share your symptoms for diagnosis!",
                style: TextStyle(color: greyColor, fontSize: 15),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                "Symptoms",
                style: TextStyle(
                    color: darkPurple,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: height * 0.01,
              ),

              // Symptoms Selector
              ChipsChoice<String>.multiple(
                padding: const EdgeInsets.only(bottom: 12),
                alignment: WrapAlignment.start,
                value: tags,
                onChanged: (val) => setState(() {
                  symptoms = {
                    "cough": "False",
                    "fever": "False",
                    "sore_throat": "False",
                    "shortness_of_breath": "False",
                    "headache": "False",
                    "old_age": user1.age > oldAgeCriterion ? "True" : "False",
                    "contact": "False"
                  };
                  tags = val;
                  mapSymptoms(symptoms, tags);
                }),
                choiceItems: C2Choice.listFrom(
                  source: options,
                  value: (i, v) => v,
                  label: (i, v) => v,
                ),
                choiceCheckmark: true,
                choiceStyle: C2ChipStyle.outlined(
                  color: darkPurple,
                  overlayColor: primaryColor,
                  foregroundStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                    color: darkPurple,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  checkmarkColor: Colors.white,
                  checkmarkStyle: C2ChipCheckmarkStyle.round,
                  checkmarkWeight: 1.5,
                  selectedStyle: C2ChipStyle.filled(
                    overlayColor: Colors.white,
                    foregroundStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                    ),
                    color: primaryColor,
                    backgroundOpacity: 1,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                wrapped: true,
                textDirection: TextDirection.ltr,
              ),

              Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                  decoration: BoxDecoration(
                    // border: Border.all(width: 1, color: greyColor),
                    borderRadius: BorderRadius.circular(30),
                    color: blueTint,
                  ),
                  child: TextFormField(
                    controller: _descriptionController,
                    cursorColor: primaryColor,
                    maxLength: 240,
                    maxLines: 3,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      // contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      hintText: "Other Symptoms",
                    ),
                  )),
              SizedBox(
                height: height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Image",
                    style: TextStyle(
                        color: darkPurple,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  _imageFile.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            clearImage();
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: greyColor,
                          ))
                      : const SizedBox()
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              GestureDetector(
                onTap: () => _selectImage(context),
                child: Container(
                  width: double.infinity,
                  height: _imageFile.isNotEmpty ? height * 0.35 : height * 0.15,
                  decoration: BoxDecoration(
                    // border: Border.all(width: 1, color: greyColor),
                    borderRadius: BorderRadius.circular(30),
                    color: blueTint,
                  ),
                  child: _imageFile.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image(
                            image: MemoryImage(_imageFile),
                            width: double.infinity,
                            height: height * 0.35,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Center(
                          child: Icon(
                          Icons.add_a_photo_outlined,
                          color: greyColor,
                          size: width * 0.15,
                        )),
                ),
              ),

              SizedBox(
                height: height * 0.03,
              ),

              Row(
                children: [
                  //Voice Input
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Voice",
                              style: TextStyle(
                                  color: darkPurple,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            _audioFilePath.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      clearAudio();
                                    },
                                    icon: Icon(
                                      Icons.cancel,
                                      color: greyColor,
                                    ))
                                : const SizedBox()
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            _selectVoice(context);
                          },
                          child: Container(
                            // width: double.infinity,
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: blueTint,
                            ),
                            child: _audioFilePath.isNotEmpty
                                ? Center(
                                    child: IconButton(
                                      splashRadius: 9000,
                                      splashColor: Colors.black,
                                      icon: Icon(
                                        _isAudioPlaying
                                            ? Icons.pause_circle
                                            : Icons.play_circle,
                                        color: primaryColor,
                                        size: width * 0.2,
                                      ),
                                      onPressed: () async {
                                        _isAudioPlaying
                                            ? await player?.pause()
                                            : await player?.play(
                                                DeviceFileSource(
                                                    _audioFilePath));
                                      },
                                    ),
                                  )
                                : Center(
                                    child: Icon(
                                    Icons.multitrack_audio_rounded,
                                    color: greyColor,
                                    size: width * 0.15,
                                  )),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: width * 0.04,
                  ),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Video",
                              style: TextStyle(
                                  color: darkPurple,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            isVideoPresent
                                ? IconButton(
                                    onPressed: () {
                                      clearVideo();
                                    },
                                    icon: Icon(
                                      Icons.cancel,
                                      color: greyColor,
                                    ))
                                : const SizedBox()
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            _selectVideo(context);
                          },
                          child: Container(
                            // width: double.infinity,
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: blueTint,
                            ),
                            child: isVideoPresent
                                ? Center(
                                    child: IconButton(
                                      splashRadius: 9000,
                                      splashColor: Colors.black,
                                      icon: Icon(
                                        Icons.video_camera_front_rounded,
                                        color: primaryColor,
                                        size: width * 0.2,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => MyVideoPlayer(
                                              file: _videoFile,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Center(
                                    child: Icon(
                                    Icons.video_call_outlined,
                                    color: greyColor,
                                    size: width * 0.15,
                                  )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Expanded(
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  // Text(
                  //   "Video",
                  //   style: TextStyle(
                  //       color: darkPurple,
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.w600),
                  // ),
                  // SizedBox(
                  //   height: height * 0.01,
                  // ),
                  // Container(
                  //   // width: double.infinity,
                  //   height: height * 0.15,
                  //   decoration: BoxDecoration(
                  //     // border: Border.all(width: 1, color: greyColor),
                  //     borderRadius: BorderRadius.circular(30),
                  //     color: blueTint,
                  //   ),
                  //   child: Center(
                  //       child: Icon(
                  //     Icons.video_call_outlined,
                  //     color: greyColor,
                  //     size: width * 0.15,
                  //   )),
                  // ),
                  //       ],
                  //     ),
                  //   ),
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),

              // Submit
              GestureDetector(
                onTap: () async {
                  submitInputs(user1.uid, name, user1.profImageUrl);
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(color: Color(0x90585be4), blurRadius: 20),
                    ],
                    borderRadius: BorderRadius.circular(50),
                    color: primaryColor,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: isLoading
                      ? LinearProgressIndicator(
                          color: whiteColorTransparent,
                          backgroundColor: primaryColor,
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Diagnose ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_sharp,
                              size: 20.0,
                              color: Colors.white,
                              weight: 100,
                            )
                          ],
                        ),
                ),
              ),
              submissionStatus,
              SizedBox(
                height: height * 0.1,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
