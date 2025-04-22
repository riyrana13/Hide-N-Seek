// lib/screens/hide_message_screen.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:hide_n_seek/services/exifservice.dart';
import 'package:hide_n_seek/widgets/image_picker.dart';

class HideMessageScreen extends StatefulWidget {
  const HideMessageScreen({super.key});

  @override
  _HideMessageScreenState createState() => _HideMessageScreenState();
}

class _HideMessageScreenState extends State<HideMessageScreen> {
  File? _selectedImage;
  final _messageController = TextEditingController();
  final _exifService = ExifService();

  void _onImageSelected(File image) {
    setState(() => _selectedImage = image);
  }

  Future<void> _saveMessageToImage(BuildContext context) async {
    if (_selectedImage == null || _messageController.text.trim().isEmpty) {
      return;
    }

    await _exifService.writeMessageToExif(
      _selectedImage!,
      _messageController.text,
    );

    await GallerySaver.saveImage(_selectedImage!.path, albumName: 'HideNSeek');

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.deepPurple.shade50,
        content: const Text(
          ' Your secret message has been successfully hidden! The image is now saved in your gallery under the “HideNSeek” album.',
          style: TextStyle(color: Colors.black),
        )));
    setState(() {
      _selectedImage = null;
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Hide Message',
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Choose an image and write a message to hide inside the image metadata (EXIF). ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            const Text(
              'Once done, the image will be saved to your gallery in the "HideNSeek" album.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            ImagePickerButton(
              onImageSelected: _onImageSelected,
              label: 'Pick Image',
              allowChoice: true,
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
            TextField(
              controller: _messageController,
              maxLines: 5,
              minLines: 3,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                labelText: 'Enter secret message',
                hintText: 'Type your message here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.deepPurple.shade50,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveMessageToImage(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Save Message to Image',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
