import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:youtubeclonenow2/cores/screens/error_page.dart';
import 'package:youtubeclonenow2/cores/screens/loader.dart';
import 'package:youtubeclonenow2/features/content/Long_video/parts/post.dart';
import 'package:youtubeclonenow2/features/upload/long_video/video_model.dart';
class LongVideoScreen extends StatelessWidget {
  const LongVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseFirestore.instance.collection("videos").snapshots()
        , builder: (context,snapshot){
      if(!snapshot.hasData){
        return ErrorPage();
      }
      else if(snapshot.connectionState==ConnectionState.waiting){
        return Loader();
      }

      final videoMaps =snapshot.data!.docs;
      final videos= videoMaps.map((video){
        return VideoModel.fromJson(video.data());
      }).toList();
        return ListView.builder(itemCount: videos.length, itemBuilder:(context,index){
          return Post(video: videos[index]);
        }
        );
        });
  }
}
