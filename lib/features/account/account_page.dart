import 'package:flutter/material.dart';
import 'package:youtubeclonenow2/features/account/items.dart';
class Account_Page extends StatelessWidget {
  const Account_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Items(),
            ),
          ],
        ),
      ),
    );
  }
}
