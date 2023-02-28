import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../backend/api.dart';

// ignore: camel_case_types
class tabview extends StatefulWidget {
  const tabview({super.key, required this.title});

  final String title;

  @override
  State<tabview> createState() => _tabviewState();
}

class _tabviewState extends State<tabview> {
  late Future<forecast> futureAlbum;
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });

    // searchResults = results('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 100,
        height: 100,
        child: VideoPlayer(_controller),
      ),
    );
  }
}
