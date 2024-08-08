import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtubeclonenow2/features/upload/long_video/video_model.dart';

final longvideoProvider= Provider((ref)=>VideoRepository(firestore: FirebaseFirestore.instance));

class VideoRepository {
  final FirebaseFirestore firestore;


  VideoRepository({required this.firestore});

  Future<void> uploadvideoToFirestore({
    required String videoUrl,
    required String thumbnail,
    required String title,
    required DateTime datepublished,
    required String videoId,
    required String usedId,
  }) async {
    VideoModel video = VideoModel(
      videoUrl: videoUrl,
      thumbnail: thumbnail,
      title: title,
      datepublished: datepublished,
      views: 0,
      videoId: videoId,
      usedId: usedId,
      likes: [],
      type: "video",
    );

    await firestore.collection('videos').doc(videoId).set(video.toJson());
  }
}
