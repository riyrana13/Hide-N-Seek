// lib/services/exif_service.dart

import 'dart:convert';
import 'dart:io';

import 'package:native_exif/native_exif.dart';

class ExifService {
  Future<void> writeMessageToExif(File image, String message) async {
    final exif = await Exif.fromPath(image.path);
    await exif.writeAttributes({
      'UserComment': jsonEncode({
        'message': message,
        'timestamp': DateTime.now().toIso8601String(),
      }).toString(),
    });
  }

  // Future<String?> readMessageFromExif(File image) async {
  //   final exif = await Exif.fromPath(image.path);
  //   final attrs = await exif.getAttributes();
  //   final comment = attrs?['UserComment'];
  //   if (comment != null) {
  //     try {
  //       return jsonDecode(comment.toString())['message'];
  //     } catch (e) {
  //       return null;
  //     }
  //   }
  //   return null;
  // }
  Future<String?> readMessageFromExif(File image) async {
    try {
      final exif = await Exif.fromPath(image.path);
      final attrs = await exif.getAttributes();
      final comment = attrs?['UserComment'];

      if (comment != null) {
        try {
          final decoded = jsonDecode(comment.toString());
          if (decoded is Map<String, dynamic> &&
              decoded.containsKey('message')) {
            return decoded['message'];
          }
        } catch (_) {
          return comment.toString();
        }
      }

      return 'No user comment found.';
    } catch (e) {
      print('Error reading EXIF comment: $e');
      return 'Failed to read EXIF comment.';
    }
  }
}
