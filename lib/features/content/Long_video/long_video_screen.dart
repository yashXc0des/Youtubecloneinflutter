import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:youtubeclonenow2/features/content/Long_video/parts/post.dart';
class LongVideoScreen extends StatelessWidget {
  const LongVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseFirestore.instance.collection("videos").snapshots()
        , builder: (context,snapshot){
        return ListView.builder(itemCount: 1, itemBuilder:(context,index){
          return Post();
        }
        );
        });
  }
}
