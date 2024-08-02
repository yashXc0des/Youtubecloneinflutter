import 'package:flutter/material.dart';
class Tabbarview extends StatelessWidget {
  const Tabbarview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
        child: TabBarView(children: [
          Center(child: Text("Home")),
          Center(child: Text("videos")),
          Center(child: Text("shorts")),
          Center(child: Text("community")),
          Center(child: Text("playlist")),
          Center(child: Text("channel")),
          Center(child: Text("about")),



        ]));
  }
}
