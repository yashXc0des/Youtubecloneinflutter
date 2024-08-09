// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youtubeclonenow2/features/content/long_video/video_details.dart';

void showErrorSnackBar(String message, BuildContext context) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );

Future<String?> putFileInStorage(File file, String number, String filetype) async {
  try {
    final ref = FirebaseStorage.instance.ref().child("$filetype/$number");
    final upload = ref.putFile(file);
    final snapshot = await upload.whenComplete(() {});
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  } catch (e) {
    print('Error uploading file: $e');
    return null;
  }
}


Future<File?> pickImage() async {
  XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
  return file != null ? File(file.path) : null;
}
Future<File?> pickVideo(BuildContext context) async {
  XFile? file = await ImagePicker().pickVideo(source: ImageSource.gallery);
  if (file != null) {
    File video = File(file.path);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UploadVideoDetailsPage(video: video)),
    );
    return video;
  }
  return null;
}



