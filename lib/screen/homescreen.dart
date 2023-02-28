import 'dart:html';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weatherapp/backend/api.dart';
import 'package:weatherapp/screen/hoe.dart';
import 'package:weatherapp/widget/home2.dart';

import '../widget/columns.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Location1> futureAlbum;
  late Future<List<search1>> searchResults;
  String city = 'london';
  bool vision = false;
  TextEditingController x = TextEditingController();
  String keyword = '';
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(city);
    fetchJson(keyword).then((value) {
      setState(() {
        well.addAll(value);
      });
    });
    // searchResults = results('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0,
        title: Stack(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                  child: AnimSearchBar(
                width: MediaQuery.of(context).size.width - 150,
                color: Colors.blue,
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
              )),
            ],
          ),
        ]),
      ),
      body: Column(
        children: [
          Stack(children: [
            Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35))),
                child: FutureBuilder<Location1>(
                    future: futureAlbum,
                    builder: (context, snapshot) {
                      print(snapshot.hasData);
                      if (snapshot.hasData) {
                        return Column(children: [
                          Text(
                            snapshot.data!.name,
                            // ignore: prefer_const_constructors
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(snapshot.data!.region,
                              style:
                                  // ignore: prefer_const_constructors
                                  TextStyle(color: Colors.white, fontSize: 10)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                snapshot.data!.link,
                                width: 150,
                                height: 150.5,
                                fit: BoxFit.cover,
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${snapshot.data!.temp_c.toString()}c',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 50),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [],
                          ),
                        ]);
                      } else if (snapshot.hasError) {
                        // print('sex');
                        return Text('${snapshot.error}',
                            style: TextStyle(color: Colors.white));
                      }
                      return Container(
                        child: CircularProgressIndicator(
                          strokeWidth: 1.0,
                          color: Colors.white,
                        ),
                      );
                    })),
            Visibility(
              visible: vision,
              child: Center(
                  child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width - 150,
                child: ListView.builder(
                    itemCount: well.length,
                    itemBuilder: ((context, index) {
                      return Card(
                        child: Column(
                          children: [
                            GestureDetector(
                              child: Text(well[index].name.toString()),
                              onTap: () {
                                setState(() {
                                  city = well[index].name;
                                  futureAlbum = fetchAlbum(city);
                                  vision = false;
                                });
                              },
                            )
                          ],
                        ),
                      );
                    })),
              )),
            )
          ]),
           // tabview(title: '')
        ],
      ),
      drawer: Drawer(
          width: 300,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blueAccent),
                  child: Text('Countries')),
              ListTile(
                title: const Text('Addis Ababa'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    city = 'Addis Ababa';
                    futureAlbum = fetchAlbum(city);
                  });
                },
              ),
              ListTile(
                title: const Text('New york'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    city = 'New york';
                    futureAlbum = fetchAlbum(city);
                  });
                },
              )
            ],
          )),
    );
  }
}
