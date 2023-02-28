import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../backend/api.dart';

// ignore: camel_case_types
class tabview extends StatefulWidget {
  const tabview({ required this.title});

  final String title;

  @override
  State<tabview> createState() => _tabviewState();
}

class _tabviewState extends State<tabview> {
  late Future<forecast> futureAlbum;
  @override
  void initState() {
    super.initState();

    // searchResults = results('');
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  text: 'Friday',
                ),
                Tab(
                  text: 'Saturday',
                ),
                Tab(
                  text: 'Sunday',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    child: ListView.builder(
                        itemCount: metro.length,
                        itemBuilder: ((context, index) {
                          return Card(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Maximum Temprature'),
                                    Text('${metro[index].maxtempC.toString()}',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Maximum Temprature'),
                                    Text('${metro[index].maxtempF.toString()}',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Maximum Temprature'),
                                    Text('${metro[index].mintempC.toString()}',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Minimum Temprature',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text('${metro[index].mintempF.toString()}',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Average Temprature(C)',
                                        style: TextStyle(color: Colors.white)),
                                    Text('${metro[index].avgtempC.toString()}',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Average Tempratire(F)'),
                                    Text('${metro[index].avgtempF.toString()}',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ],
                            ),
                          );
                        })),
                  ),
                  Container(
                      child: Text('Tab View 2',
                          style: TextStyle(color: Colors.white))),
                  Text(
                    'Tab View 3',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
