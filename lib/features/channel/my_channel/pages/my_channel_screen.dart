import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyChannelScreen extends StatelessWidget {
  const MyChannelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.green,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text("Ahmad Amini",style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(text: const TextSpan(
                    style:TextStyle(color: Colors.blueGrey),
                    children: [
                  TextSpan(text: "Admad Amini "),
                    TextSpan(text: "No subscription "),
                    TextSpan(text: "No videos")
                ])),
              ),
              Text("More about this channel ")
            ],
          ),
        ),
      ),
    );
  }
}
