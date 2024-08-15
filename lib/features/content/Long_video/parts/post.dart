import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtubeclonenow2/features/content/Long_video/parts/video.dart';

import '../../../../auth/model/user_model.dart';
import '../../../../auth/provider/user_provider.dart';
import '../../../upload/long_video/video_model.dart';

class Post extends ConsumerWidget {
  final VideoModel video;
  const Post({Key? key, required this.video}):super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final AsyncValue<UserModel> usermodel =ref.watch(anyUserDataProvider(video.usedId));
    final user =usermodel.whenData((user)=> user);
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>Video(video: video,)));
            },
            child: Container(
              height: 200,
              color: Colors.black87,  // Set the background color to grey
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: [
                  // The grey background
                  CachedNetworkImage(
                    imageUrl: video.thumbnail,
                  ),
                  // The image with BoxFit.cover to fill the container as much as possible
                  Container(
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    child: user.when(
                      data: (userData) {
                        return ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: userData.profilePic, // Access the profilePic directly from userData
                          ),
                        );
                      },
                      loading: () => CircularProgressIndicator(),
                      error: (error, stack) => Text("Error: $error"),
                    )

                ),
                SizedBox(width: 5), // Adding space between CircleAvatar and Column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(height: 4),
                    Container(
                      width: 240,
                      child: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              user.value!.displayName,
                              style: TextStyle(color: Colors.blueGrey,fontSize:10),
                            ), // Spacer to push the remaining text to the right
                            Text(
                              video.views == 0 ? "NO VIEWS" : "${video.views.toString()} views",
                              style: TextStyle(color: Colors.blueGrey,fontSize:10),
                            ), // Adding space between elements
                            Text(
                              video.datepublished.toString() ,
                              style: TextStyle(color: Colors.blueGrey,fontSize:10),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
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
