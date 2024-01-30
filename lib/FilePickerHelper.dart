
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PickFilePathResult {
  PlatformFile? file;

  // print(file.name);
  // print(file.bytes);
  // print(file.size);
  // print(file.extension);
  // print(file.path);

  String filePath;
  String base64;

  PickFilePathResult({
    this.file,
    this.filePath = "",
    this.base64 = "",
  });
}

Future<PickFilePathResult?> pickFilePath() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  PickFilePathResult? fullRes = PickFilePathResult();
  if (result != null) {
    PlatformFile file = result.files.first;
    fullRes.file = file;
    fullRes.filePath = result.files.single.path ?? 'No file path';
    fullRes.base64 = convertToBase64(fullRes.filePath.toString());
  } else {
    // User canceled the picker
    fullRes = null;
  }
  return fullRes;
}

Widget getFileIcon(String filePath) {
  if (filePath.toLowerCase().endsWith('.pdf')) {
    return const Icon(Icons.picture_as_pdf, size: 48, color: Colors.red);
  } else if (filePath.toLowerCase().endsWith('.txt')) {
    return const Icon(Icons.text_snippet, size: 48, color: Colors.red);
  } else if (filePath.toLowerCase().endsWith('.jpeg') || filePath.toLowerCase().endsWith('.jpg') || filePath.toLowerCase().endsWith('.png')) {
    return Image.file(File(filePath), width: 48, height: 48);
  } else {
    return const Icon(Icons.folder, size: 48, color: Colors.grey);
  }
}

String convertToBase64(String filePath) {
  if (File(filePath).existsSync()) {
    List<int> bytes = File(filePath).readAsBytesSync();
    String base64String = base64Encode(bytes);
    return base64String;
  } else {
    return "";
  }
}
