import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:youtubeclonenow2/cores/methods.dart';
import 'package:youtubeclonenow2/features/upload/long_video/video_repository.dart';
import 'package:youtubeclonenow2/utils/custom_textfield.dart';

class UploadVideoDetailsPage extends ConsumerStatefulWidget {
  //final File video;
   UploadVideoDetailsPage( {super.key} );

  @override
  ConsumerState<UploadVideoDetailsPage> createState() => _UploadVideoDetailsPageState();
}

class _UploadVideoDetailsPageState extends ConsumerState<UploadVideoDetailsPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  File? image;
  bool isThumbnailUsed = false;
  String videoid = const Uuid().v4();
  String randomnumner = const Uuid().v4();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8, top: 20, bottom: 10),
                  child: Text("Enter title for your video", style: TextStyle(fontSize: 18)),
                ),
                CustomTextField(
                  "Title",
                  null,
                  false,
                  true,
                  Icon(Icons.title),
                  titleController,
                  false,
                  null,
                  null,
                ),
                const SizedBox(height: 5),
                const Padding(
                  padding: EdgeInsets.only(left: 8, top: 1, bottom: 10),
                  child: Text("Enter description for your video", style: TextStyle(fontSize: 18)),
                ),
                CustomTextField(
                  "DESCRIPTION",
                  null,
                  false,
                  true,
                  Icon(Icons.description),
                  descriptionController,
                  null,
                  7,
                  500,
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () async {
                    File? pickedImage = await pickImage();
                    if (pickedImage != null) {
                      setState(() {
                        image = pickedImage;
                        isThumbnailUsed = true;
                      });
                    }
                  },
                  child: const Text("Upload Thumbnail"),
                ),
                isThumbnailUsed
                    ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(
                    image!,
                    fit: BoxFit.cover,
                    cacheHeight: 160,
                    cacheWidth: 400,
                  ),
                )
                    : const SizedBox(height: 100),
                TextButton(
                  onPressed: () async {
                    if (image != null) {
                      String thumbnail = await putFileInStorage(image!, randomnumner, "image");
                      await ref.watch(longvideoProvider).uploadvideoToFirestore(
                        videoUrl: video, // Ensure path is correct
                        thumbnail: thumbnail,
                        title: titleController.text,
                        datepublished: DateTime.now(),
                        videoId: videoid,
                        usedId: FirebaseAuth.instance.currentUser!.uid,
                      );
                    }
                  },
                  child: const Text("PUBLISH"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
