import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../auth/model/user_model.dart';
class Toppart extends StatelessWidget {
  final UserModel user;
  const Toppart({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 38,
          backgroundColor: Colors.green,
          backgroundImage: CachedNetworkImageProvider(user.profilePic),
        ),
        Text(user.displayName,style: const TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold
        ),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(text:  TextSpan(
              style:const TextStyle(color: Colors.blueGrey),
              children: [
                TextSpan(text: "${user.username} "),
                TextSpan(text: "${user.subscription.length} Subscription "),
                TextSpan(text: "${user.videos} Videos")
              ])),
        ),
      ],
    );
  }
}
