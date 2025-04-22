// lib/screens/reveal_message_screen.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hide_n_seek/services/exifservice.dart';
import 'package:hide_n_seek/widgets/image_picker.dart';

class RevealMessageScreen extends StatefulWidget {
  const RevealMessageScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RevealMessageScreenState createState() => _RevealMessageScreenState();
}

class _RevealMessageScreenState extends State<RevealMessageScreen> {
  File? _selectedImage;
  String? _message;
  final _exifService = ExifService();

  void _onImageSelected(File image) async {
    final message = await _exifService.readMessageFromExif(image);
    setState(() {
      _selectedImage = image;
      _message = message ?? 'No message found.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Reveal Message',
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Select an image to scan for a hidden message stored in the metadata (EXIF).',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            ImagePickerButton(
              onImageSelected: _onImageSelected,
              label: 'Pick Image',
            ),
            const SizedBox(height: 20),
            if (_selectedImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  _selectedImage!,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            if (_message != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  'It says: $_message',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
