import 'package:docotg/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';


pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  } else {
  }
}

pickAudio() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.audio,
  );

  if (result != null) {
    return await result.files.single.path;
  } else {
  }
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            content,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
          ),
          backgroundColor: blueTint,
      )
    );
}

// showBottomSheet(){
//   showModalBottomSheet(
//     backgroundColor: Colors.transparent,
//     context: context,
//     builder: (BuildContext bc) {
//       return Container(
//         height: height*0.3,
//         decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//
//             children: [
//
//               Row(
//                 children: [
//                   SizedBox(width: width*0.1,),
//                   const Icon(Icons.settings),
//                   SizedBox(width: width*0.07,),
//                   const Text("Settings",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)
//                 ],
//               ),
//               SizedBox(height: height*0.02,),
//               Row(
//                 children: [
//                   SizedBox(width: width*0.1,),
//                   const Icon(Icons.info_rounded),
//                   SizedBox(width: width*0.07,),
//                   const Text("About us",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)
//                 ],
//               ),
//               SizedBox(height: height*0.02,),
//               Row(
//                 children: [
//                   SizedBox(width: width*0.1,),
//                   const Icon(Icons.support_agent),
//                   SizedBox(width: width*0.07,),
//                   const Text("Support",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)
//                 ],
//               ),
//               SizedBox(height: height*0.025,),
//               Row(
//                 children: [
//                   SizedBox(width: width*0.1,),
//                   const Icon(Icons.share),
//                   SizedBox(width: width*0.07,),
//                   const Text("Share",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)
//                 ],
//               )
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }