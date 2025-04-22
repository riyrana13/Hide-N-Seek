// lib/widgets/image_picker_button.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerButton extends StatelessWidget {
  final void Function(File image) onImageSelected;
  final String label;
  final bool useCamera;
  final bool allowChoice;

  const ImagePickerButton({
    required this.onImageSelected,
    this.label = 'Pick Image',
    this.useCamera = false,
    this.allowChoice = false,
    Key? key,
  }) : super(key: key);

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    ImageSource source = useCamera ? ImageSource.camera : ImageSource.gallery;

    if (allowChoice) {
      final selected = await showDialog<ImageSource>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Choose Image Source'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, ImageSource.camera),
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, ImageSource.gallery),
              child: const Text('Gallery'),
            ),
          ],
        ),
      );

      if (selected != null) {
        source = selected;
      } else {
        return;
      }
    }

    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      onImageSelected(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _pickImage(context),
      child: Text(label),
    );
  }
}
