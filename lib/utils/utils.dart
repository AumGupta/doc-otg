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

List<Color> getReportStatusColors(String status) {
  return status=='Positive'?[redColor,lightRedColor]:[greenColor,lightGreenColor];
}
IconData getReportStatusBadge(String status) {
  return status=='Positive'?Icons.report_rounded
      :Icons.verified_rounded;
}