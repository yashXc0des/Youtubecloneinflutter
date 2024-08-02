import 'package:flutter/material.dart';
class Toppart extends StatelessWidget {
  const Toppart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: CircleAvatar(
            radius: 38,
            backgroundColor: Colors.green,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Ahmad Amini",style: TextStyle(
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
      ],
    );
  }
}
