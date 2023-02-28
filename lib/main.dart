import 'dart:async';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:weatherapp/screen/homescreen.dart';
import 'package:chewie/chewie.dart';

import 'backend/api.dart';

void main() => runApp(const VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  const VideoPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late Future<Location1> futureAlbum;
  late Future<List<search1>> searchResults;
  String keyword = '';
  String city = 'london';
  TextEditingController x = TextEditingController();
  bool vision = false;
  // late Future<Location1> futureAlbum;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset('assets/videos/1.mp4');

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.play();
    // Use the controller to loop the video.
    _controller.setLooping(true);
    _controller.setVolume(0.0);
    futureAlbum = fetchAlbum(city);
    fetchJson(keyword).then((value) {
      setState(() {
        well.addAll(value);
      });
    });
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: AlignmentDirectional.topStart, children: [
        Container(
            width: double.infinity,
            height: double.maxFinite,
            child: VideoPlayer(_controller)),
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(),
                      AnimSearchBar(
                        width: MediaQuery.of(context).size.width - 150,
                        color: Color(0x0013),
                        textController: x,
                        onSuffixTap: () {
                          setState(() {
                            vision = true;
                          });
                        },
                        onSubmitted: (String) {
                          setState(() {
                            vision = true;
                          });
                          fetchJson(x.text).then((value) {
                            setState(() {
                              well.addAll(value);
                            });
                          });
                        },
                      )
                    ],
                  ),
                  Text(
                    "Addis Ababa",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'sans-serif'),
                  ),
                  Text(
                    "21c",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'sans-serif'),
                  ),
                  Text(
                    "Mostly Cloudy",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'sans-serif'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 70, 1, 1),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 170,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(25)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 70, 1, 1),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 400,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(25)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
