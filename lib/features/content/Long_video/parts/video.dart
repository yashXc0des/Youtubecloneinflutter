import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:youtubeclonenow2/auth/model/user_model.dart';
import 'package:youtubeclonenow2/auth/provider/user_provider.dart';
import 'package:youtubeclonenow2/cores/screens/error_page.dart';
import 'package:youtubeclonenow2/cores/screens/loader.dart';
import 'package:youtubeclonenow2/features/upload/long_video/video_model.dart';

import '../../../../cores/colors.dart';
import '../../../../cores/widgets/flat_button.dart';
import '../widgets/video_externel_buttons.dart';

class Video extends ConsumerStatefulWidget {
  final VideoModel video;
  const Video({Key? key, required this.video}) : super(key: key);

  @override
  ConsumerState<Video> createState() => _VideoState();
}

class _VideoState extends ConsumerState<Video> {
  VideoPlayerController? _controller;
  bool isShowIcons = false;
  bool isPlayingVideo = false;

  void goBackward() {
    Duration position = _controller!.value.position;
    position -= Duration(seconds: 1);
    _controller!.seekTo(position);
  }

  void goForward() {
    Duration position = _controller!.value.position;
    position += Duration(seconds: 1);
    _controller!.seekTo(position);
  }
  void enterFullscreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenVideoPage(controller: _controller!),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.video.videoUrl),
    )
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    // Correctly use 'ref' to get the user data
    final userAsync = ref.watch(anyUserDataProvider(widget.video.usedId));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(176),
          child: Container(
            height: 200,
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isShowIcons = !isShowIcons;
                  });
                },
                child: Stack(
                  children: [
                    VideoPlayer(_controller!),
                    if (isShowIcons) ...[
                      if (isPlayingVideo)
                        Positioned(
                          left: 150,
                          top: 79,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isPlayingVideo = false;
                                _controller!.pause();
                              });
                            },
                            child: SizedBox(
                              height: 50,
                              child: Image.asset(
                                "assets/images/pause.png",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      else
                        Positioned(
                          left: 150,
                          top: 79,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isPlayingVideo = true;
                                _controller!.play();
                              });
                            },
                            child: SizedBox(
                              height: 50,
                              child: Image.asset(
                                "assets/images/play.png",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        left: 45,
                        top: 79,
                        child: GestureDetector(
                          onTap: goBackward,
                          child: SizedBox(
                            height: 50,
                            child: Image.asset(
                              "assets/images/go_back_final.png",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: IconButton(
                          icon: Icon(Icons.fullscreen, color: Colors.white),
                          onPressed: enterFullscreen,
                        ),
                      ),
                      Positioned(
                        right: 45,
                        top: 78,
                        child: GestureDetector(
                          onTap: goForward,
                          child: SizedBox(
                            height: 50,
                            child: Image.asset(
                              "assets/images/go_ahead_final.png",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 7.5,
                        child: VideoProgressIndicator(
                          _controller!,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                            bufferedColor: Colors.white38,
                            playedColor: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Text(
                widget.video.title,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      "${widget.video.views.toString()} Views",
                      style: const TextStyle(
                        fontSize: 13.4,
                        color: Color(0xff5F5F5F),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(DateFormat('yyyy-MM-dd').format(widget.video.datepublished)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(widget.video.description),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 9, right: 9),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey,
                    backgroundImage: CachedNetworkImageProvider(userAsync.value!.profilePic),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: userAsync.when(
                      data: (userData) => Text(
                        userData.displayName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      loading: () => CircularProgressIndicator(),
                      error: (error, stack) => Text("Error: $error"),
                    ),
                  ),
                  Text("${userAsync.value?.subscription.length}"),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SizedBox(
                      height: 35,
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: FlatButton(
                          text: "Subscribe",
                          onPressed: () {},
                          colour: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9, top: 10.5, right: 9),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: const BoxDecoration(
                        color: softBlueGreyBackGround,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.thumb_up,
                              size: 15.5,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.thumb_down,
                            size: 15.5,
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 9, right: 9),
                      child: VideoExtraButton(
                        text: "Share",
                        iconData: Icons.share,
                      ),
                    ),
                    const VideoExtraButton(
                      text: "Remix",
                      iconData: Icons.analytics_outlined,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 9, right: 9),
                      child: VideoExtraButton(
                        text: "Download",
                        iconData: Icons.download,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("videos")
                  .where("videoId", isNotEqualTo: widget.video.videoId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return const ErrorPage();
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                }

                final videoDocs = snapshot.data!.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: videoDocs.length,
                  itemBuilder: (context, index) {
                    final video = VideoModel.fromSnapshot(videoDocs[index]);
                    return ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: video.thumbnail,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        video.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text("${video.views} Views • ${DateFormat('yyyy-MM-dd').format(video.datepublished)}"),
                      onTap: () {
                        // Navigate to the video page
                      },
                    );
                  },
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}

class FullScreenVideoPage extends StatelessWidget {
  final VideoPlayerController controller;

  const FullScreenVideoPage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
          Navigator.pop(context);
        },
        child: Icon(Icons.fullscreen_exit, color: Colors.black),
      ),
    );
  }
}
