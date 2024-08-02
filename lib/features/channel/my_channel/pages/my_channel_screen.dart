import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtubeclonenow2/cores/widgets/image_button.dart';
import 'package:youtubeclonenow2/features/channel/my_channel/parts/tabpartwidget.dart';

import '../parts/buttons.dart';
import '../parts/tabbarview.dart';
import '../parts/toppartwidget.dart';

class MyChannelScreen extends StatelessWidget {
  const MyChannelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(length: 7, child: Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top:10,bottom: 10,left: 5),
          child: Column(
            children: [
              Toppart(),
              buttonspart(),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: tabpart()
              ),
              Tabbarview()
            ],
          ),
        ),
      ),
    ));
  }
}
