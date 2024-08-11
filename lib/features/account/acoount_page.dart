import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youtubeclonenow2/features/account/items.dart';
class Account_Page extends StatelessWidget {
  const Account_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Items(),
            )
          ],
        ),
      ),
    );
  }
}
