import 'dart:async';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:weatherapp/screen/homescreen.dart';
import 'package:chewie/chewie.dart';
import 'package:weatherapp/widget/columns.dart';

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
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          showSearch(
                            context: context,
                            delegate: CustomSearchDelegate(),
                          );
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
                          color: Color.fromARGB(255, 68, 162, 239),
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  'Cloudy conditions expected around 2AM',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                endIndent: 3,
                                thickness: 0.07,
                                height: 1,
                                color: Colors.white,
                              ),
                              Row(
                                children: [
                                  AutocompleteApp(
                                    day: 'Now',
                                    temp: '22',
                                  ),
                                  AutocompleteApp(
                                    day: 'Wed',
                                    temp: '19',
                                  ),
                                  AutocompleteApp(
                                    day: 'Thu',
                                    temp: '25',
                                  ),
                                  AutocompleteApp(
                                    day: 'Fri',
                                    temp: '18',
                                  ),
                                  AutocompleteApp(
                                    day: 'Sat',
                                    temp: '20',
                                  ),
                                  AutocompleteApp(
                                    day: 'Sun',
                                    temp: '19',
                                  ),
                                ],
                              )
                            ]),
                      ),
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

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<String> searchTerms = ['Algeria', 'Angola', 'Afghanistan'];

  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        color: Colors.redAccent,
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  Widget buildLeading(BuildContext context) {
    color:
    Colors.black;
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  Widget buildResults(BuildContext context) {
    color:
    Colors.black;
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            tileColor: Colors.amber,
            title: Text(result),
          );
        });
  }

  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }
}
