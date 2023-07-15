import 'package:docotg/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  } else {}
}

pickAudio() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.audio,
  );

  if (result != null) {
    return await result.files.single.path;
  } else {}
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Center(
      child: Text(
        content,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: darkPurple,
        ),
      ),
    ),
    backgroundColor: blueTint,
    showCloseIcon: true,
    closeIconColor: darkPurple,
  ));
}

List<Color> getReportStatusColors(String status) {
  return status == 'Positive'
      ? [redColor, lightRedColor]
      : [greenColor, lightGreenColor];
}

IconData getReportStatusIcon(String status) {
  return status == 'Positive' ? Icons.report_rounded : Icons.verified_rounded;
}
