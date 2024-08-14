import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl:
            "https://i0.wp.com/eckyledavidsonneedforspeed.wordpress.com/wp-content/uploads/2017/10/nfs-most-wanted-bmw-wallpaperswallpapers-nfs-mostwanted-gtr-bmw-m-most-wanted-800x600-47422-jfevu13d.jpg?w=2500&h=&ssl=1",
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 20,
                ),
                SizedBox(width: 5), // Adding space between CircleAvatar and Column
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TITLE",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            "CHANNEL NAME",
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                          Spacer(), // Spacer to push the remaining text to the right
                          Text(
                            "0",
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                          SizedBox(width: 8), // Adding space between elements
                          Text(
                            "DAYS SINCE PUBLISHED",
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    // Add your desired functionality here
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
