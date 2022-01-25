import 'dart:convert';
import 'package:http/http.dart' as http;

class Accident {
  final int avalancheNumber;
  final String url;
  final String location;
  final String state;
  final String date;
  final String summaryDescription;
  final String primaryActivity;
  final String primaryTravelMode;
  final String locationSetting;
  final int killed;
  final String type;
  final String latitude;
  final String longitude;
  final String html;
  final String auidoUrl;

  const Accident({
    required this.avalancheNumber,
    required this.url,
    required this.location,
    required this.state,
    required this.date,
    required this.summaryDescription,
    required this.primaryActivity,
    required this.primaryTravelMode,
    required this.locationSetting,
    required this.killed,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.html,
    required this.auidoUrl,
  });

  factory Accident.fromJson(Map<String, dynamic> json) {
    return Accident(
      avalancheNumber: json['avalanche_number'] as int,
      url: json['url'] as String,
      location: json['location'] as String,
      state: json['state'] as String,
      date: json['date'] as String,
      summaryDescription: json['summary_description'] as String,
      primaryActivity: json['primary_activity'] as String,
      primaryTravelMode: json['primary_travel_mode'] as String,
      locationSetting: json['location_setting'] as String,
      killed: json['killed'] as int,
      type: json['type'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      html: json['html'] as String,
      auidoUrl: json['audio_url'] as String,
    );
  }
}

class NetworkHelper {
  NetworkHelper({this.url = ''});

  final String url;

  List<Accident> parseAccidents(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    final parsedList =
        parsed.map<Accident>((json) => Accident.fromJson(json)).toList;

    return parsedList;
  }

  Future<List<Accident>> fetchData() async {
    // Try HTTP request. Create Error Responses if unsuccesful
    http.Response response = await http.get(
      Uri.parse(url),
    );

    List<Accident> decodedData = parseAccidents(response.body);
    return decodedData;
  }
}
