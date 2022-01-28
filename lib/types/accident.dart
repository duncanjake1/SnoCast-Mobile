import 'package:flutter/material.dart';

class Accident {
  final Key key;
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
    required this.key,
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
      key: UniqueKey(),
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
