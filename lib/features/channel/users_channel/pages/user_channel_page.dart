import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:youtubeclonenow2/cores/widgets/flat_button.dart';
class UserChannelPage extends StatefulWidget {
  const UserChannelPage({super.key});

  @override

  State<UserChannelPage> createState() => _UserChannelPageState();
}

class _UserChannelPageState extends State<UserChannelPage> {
  bool havevideos=false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/images/flutter background.png"),
            Padding(
              padding: EdgeInsets.only(top: 10,left: 10,right: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 34,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ahman Amini",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                        Text("@ahmadamini"),
                       RichText(text:
                         TextSpan(
                           style: TextStyle(color: Colors.blueGrey),
                           children: <TextSpan>[
                             TextSpan(text: "No Subscribers "),
                             TextSpan(text: "No Videos ")
                           ]
                         ),)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("discription"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height:30,child: FlatButton(text: "SUBSCRIBE", onPressed:(){}, colour: Colors.black)),
            ),
            havevideos ? SizedBox(
            ): Expanded(child: Center(child: Text("No Videos",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold,color: Colors.blueGrey),)))
          ],
        ) ,
      ),
    );
  }
}
