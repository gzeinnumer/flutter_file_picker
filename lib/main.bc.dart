// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'dart:convert'; // Import dart:convert for Base64 conversion

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.highContrastLight(
          primary: Colors.red,
          onPrimary: Colors.red,
        ),
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
  const MyHomePage({Key? key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _filePath = 'No file selected';

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path ?? 'No file path';
      });
    }
  }

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
            GestureDetector(
              onTap: () => _convertToBase64(_filePath),
              child: _getFileIcon(_filePath),
            ),
            const SizedBox(height: 10),
            Text(_filePath),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickFile,
              child: const Text('Pick a File'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getFileIcon(String filePath) {
    if (filePath.toLowerCase().endsWith('.pdf')) {
      return const Icon(Icons.picture_as_pdf, size: 48, color: Colors.red);
    } else if (filePath.toLowerCase().endsWith('.txt')) {
      return const Icon(Icons.text_snippet, size: 48, color: Colors.red);
    } else if (filePath.toLowerCase().endsWith('.jpeg') ||
        filePath.toLowerCase().endsWith('.jpg') ||
        filePath.toLowerCase().endsWith('.png')) {
      return Image.file(File(filePath), width: 48, height: 48);
    } else {
      return const Icon(Icons.folder, size: 48, color: Colors.grey);
    }
  }

  void _convertToBase64(String filePath) {
    if (File(filePath).existsSync()) {
      List<int> bytes = File(filePath).readAsBytesSync();
      String base64String = base64Encode(bytes);
      print('Base64 String: $base64String');
      // You can use the base64String as needed (e.g., send it to a server)
    } else {
      print('File does not exist');
    }
  }
}
