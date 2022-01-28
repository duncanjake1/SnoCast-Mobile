import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:native_snocast/types/accident.dart';

class NetworkHelper {
  NetworkHelper({this.url = ''});

  final String url;

  Future<List<Accident>> fetchData() async {
    // Try HTTP request. Create Error Responses if unsuccesful
    http.Response response = await http.get(
      Uri.parse(url),
    );

    return compute(parseAccidents, response.body);
  }

  List<Accident> parseAccidents(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    final parsedList =
        parsed.map<Accident>((json) => Accident.fromJson(json)).toList();

    return parsedList;
  }
}
