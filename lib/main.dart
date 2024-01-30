// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_file_picker/FilePickerHelper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.highContrastLight(primary: Colors.red, onPrimary: Colors.red),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 16),
          backgroundColor: Colors.red,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Selected File:'),
            const SizedBox(height: 10),
            widgetPickFilePath(),
            const SizedBox(height: 10),
            Text(pickFilePath1.filePath),
            Text(pickFilePath1.base64, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  PickFilePathResult pickFilePath1 = PickFilePathResult();

  Row widgetPickFilePath() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            var result = await pickFilePath();
            if (result != null) {
              setState(() {
                pickFilePath1 = result;
              });
            }
          },
          child: getFileIcon(pickFilePath1.filePath),
        ),
        if (pickFilePath1.filePath != "")
          GestureDetector(
            child: const Icon(Icons.delete, color: Colors.red),
            onTap: () {
              setState(() {
                pickFilePath1 = PickFilePathResult();
              });
            },
          ),
      ],
    );
  }
}
