// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as Path;

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   File _videoFile;
//   StorageUploadTask _uploadTask;

//   void _startUpload() {
//     String filePath = 'videos/${Path.basename(_videoFile.path)}';

//     setState(() {
//       _uploadTask = FirebaseStorage.instance.ref().child(filePath).putFile(_videoFile);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Upload Video to Firebase Storage"),
//       ),
//       body: Column(
//         children: <Widget>[
//           if (_videoFile != null) ...[
//             Image.file(_videoFile),
//             TextButton(
//               child: Text("Upload Video"),
//               onPressed: _startUpload,
//             ),
//           ],
//           if (_uploadTask != null) ...[
//             StreamBuilder<StorageTaskEvent>(
//               stream: _uploadTask.events,
//               builder: (context, snapshot) {
//                 var event = snapshot?.data?.snapshot;

//                 double progressPercent = event != null
//                     ? event.bytesTransferred / event.totalByteCount
//                     : 0;

//                 return Column(
//                   children: [
//                     if (_uploadTask.isComplete)
//                       Text('Upload completed'),
//                     if (_uploadTask.isPaused)
//                       IconButton(
//                         icon: Icon(Icons.play_arrow),
//                         onPressed: _uploadTask.resume,
//                       ),
//                     if (_uploadTask.isInProgress)
//                       IconButton(
//                         icon: Icon(Icons.pause),
//                         onPressed: _uploadTask.pause,
//                       ),
//                     LinearProgressIndicator(value: progressPercent),
//                     Text(
//                       '${(progressPercent * 100).toStringAsFixed(2)} % ',
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           var video = await ImagePicker.pickVideo(source: ImageSource.gallery);

//           setState(() {
//             _videoFile = video;
//           });
//         },
//         child: Icon(Icons.video_library),
//       ),
//     );
//   }
// }
