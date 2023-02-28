import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/backend/searchResult.dart';

import 'forecast.dart';

List data = [];
Future<search1> results(String search) async {
  final response1 = await http.get(
      Uri.parse(
          'https://weatherapi-com.p.rapidapi.com/search.json?q={$search}'),
      headers: {
        'X-RapidAPI-Key': '0dcb321547msh484cbceafdeeb3bp1c42d4jsn274cf93cdb84',
        'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com'
      });
  if (response1.statusCode == 200) {
    print(response1.body);
    List res = json.decode(response1.body);
    //search1.map<data>[search1.fromJson()].toList();
    return search1.fromJson(jsonDecode(response1.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class search1 {
  List regionSearch;
  List countrySearch;

  search1({required this.regionSearch, required this.countrySearch});
  factory search1.fromJson(Map<List, dynamic> json) {
    return search1(
      regionSearch: json['name'].toList,
      countrySearch: json['country'].toList,
    );
  }
}

Future<Location1> fetchAlbum(String city) async {
  //String queryString = Uri.parse(queryParameters: qParameters).query;
  final response = await http.get(
    Uri.parse(
      'https://weatherapi-com.p.rapidapi.com/current.json?q={$city}',
    ),
    headers: {
      'X-RapidAPI-Key': '0dcb321547msh484cbceafdeeb3bp1c42d4jsn274cf93cdb84',
      'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com'
    },
  );

  if (response.statusCode == 200) {
    // print(response.body);
    return Location1.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Location1 {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tz_id;
  // final int localtime_epoch;
  final String localtime;
  final double temp_c;
  final double temp_f;
  final String link;
  // final String sunrise;
  // final String sunset;
  // final String moonrise;
  // final String moonset;

  const Location1({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tz_id,
    //  required this.localtime_epoch,
    required this.localtime,
    required this.temp_c,
    required this.temp_f,
    required this.link,
    // required this.sunset,
    // required this.moonrise,
    // required this.moonset,
    // required this.sunrise
  });

  factory Location1.fromJson(Map<String, dynamic> json) {
    return Location1(
      name: json['location']['name'],
      region: json['location']['region'],
      country: json['location']['country'],
      // localtime_epoch: json['location']['lat'],
      lat: json['location']['lat'],
      lon: json['location']['lon'],
      tz_id: json['location']['tz_id'],
      localtime: json['location']['localtime'],
      temp_c: json['current']['temp_c'],
      temp_f: json['current']['temp_f'],
      link: json['current']['condition']['icon'],
      // sunset: json['forcast']['forecastday']['astro']['sunset'],
      // moonrise: json['forcast']['forecastday']['astro']['moonrise'],
      // moonset: json['forcast']['forecastday']['astro']['moonset'],
      // sunrise: json['forcast']['forecastday']['astro']['sunrise'],
    );
  }
  //print(name);
}

//Future<List<forecast>> searchResults = result();
Future<List> result() async {
  //String queryString = Uri.parse(queryParameters: qParameters).query;
  final response = await http.get(
    Uri.parse(
      'https://weatherapi-com.p.rapidapi.com/current.json?q=london',
    ),
    headers: {
      'X-RapidAPI-Key': '0dcb321547msh484cbceafdeeb3bp1c42d4jsn274cf93cdb84',
      'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com'
    },
  );

  if (response.statusCode == 200) {
    // print(response.body);
    return forecast.fromJson(jsonDecode(response.body)) as List;
  } else {
    throw Exception('Failed to load album');
  }
}

class forecast {
  final double temp_c;
  final double temp_f;

  const forecast({
    required this.temp_c,
    required this.temp_f,
  });

  factory forecast.fromJson(Map<String, dynamic> json) {
    return forecast(
      temp_c: json['forecast']['forecastday[${0}]']['day']['maxtemp_c'],
      temp_f: json['forecast']['forecastday[${0}]']['day']['maxtemp_c'],
    );
  }
  //print(name);
}

final List<Welcome> well = [];
Future<List<Welcome>> fetchJson(String keyword) async {
  var response = await http.get(
      Uri.parse(
          'https://weatherapi-com.p.rapidapi.com/search.json?q=${keyword}'),
      headers: {
        'X-RapidAPI-Key': '0dcb321547msh484cbceafdeeb3bp1c42d4jsn274cf93cdb84',
        'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com'
      });

  List<Welcome> searchRes = [];
  if (response.statusCode == 200) {
    var urjson = jsonDecode(response.body);

    for (var jsondata in urjson) {
      searchRes.add(Welcome.fromJson(jsondata));
    }
  } else {}

  return searchRes;
}

final List<Day> metro = [];
Future<List<Day>> fetchmetro(String keyword) async {
  var response = await http.get(
      Uri.parse('https://weatherapi-com.p.rapidapi.com/forecast.json?q=london'),
      headers: {
        'X-RapidAPI-Key': '0dcb321547msh484cbceafdeeb3bp1c42d4jsn274cf93cdb84',
        'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com'
      });

  List<Day> metroRes = [];
  if (response.statusCode == 200) {
    var urjson = jsonDecode(response.body);

    for (var jsondata in urjson) {
      metroRes.add(Day.fromJson(jsondata));
    }
  } else {}

  return metroRes;
}
