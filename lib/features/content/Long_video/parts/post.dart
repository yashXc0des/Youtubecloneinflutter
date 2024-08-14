import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Column(
          children: [
            CachedNetworkImage(imageUrl: "https://www.google.com/imgres?imgurl=https%3A%2F%2Feckyledavidsonneedforspeed.wordpress.com%2Fwp-content%2Fuploads%2F2017%2F10%2Fnfs-most-wanted-bmw-wallpaperswallpapers-nfs-mostwanted-gtr-bmw-m-most-wanted-800x600-47422-jfevu13d.jpg&tbnid=U4koqM4viqs-pM&vet=12ahUKEwjPnfiftPSHAxVdyjgGHfIFBU0QMygGegQIARB3..i&imgrefurl=https%3A%2F%2Feckyledavidsonneedforspeed.wordpress.com%2F2017%2F10%2F31%2Fneed-for-speed-most-wanted-2005-nfs-mw-how-to-escape-the-police-with-massive-bounty%2F&docid=aVpctZes9bVW9M&w=800&h=600&q=nfs%20mw%20car&client=opera-gx&ved=2ahUKEwjPnfiftPSHAxVdyjgGHfIFBU0QMygGegQIARB3")
          ],
        ),
      );
  }
}
