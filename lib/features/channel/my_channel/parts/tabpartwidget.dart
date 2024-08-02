import 'package:flutter/material.dart';
class tabpart extends StatelessWidget {
  const tabpart({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: TabBar(
      isScrollable: true,
      labelStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500
      ),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorPadding: EdgeInsets.only(top: 10),
      tabs: [
        Text("Home"),
        Text("videos"),
        Text("shorts"),
        Text("community"),
        Text("playlist"),
        Text("channels"),
        Text("about"),
      
      ]),
    );
  }
}
