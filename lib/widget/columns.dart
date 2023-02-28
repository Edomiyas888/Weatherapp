import 'package:flutter/material.dart';

//void main() => runApp(const AutocompleteExampleApp());

class AutocompleteApp extends StatelessWidget {
  AutocompleteApp({required this.day,required this.temp});
  String day;
  String temp;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
      child: Container(
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  day,
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                Icon(
                  Icons.cloud,
                  color: Colors.white,
                ),
                Text(
                  temp,
                  style: TextStyle(color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
