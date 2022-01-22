import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/map_marker.dart';
import 'package:native_snocast/constants.dart';
import 'package:native_snocast/controllers/accident_report_controller.dart';

class MarkerListStateNotifier extends StateNotifier<MarkerList> {
  MarkerListStateNotifier([MarkerList? markerList])
      : super(markerList ?? MarkerList([]));

  void generateMapMarkers(AccidentReports bulkData) {
    List<Marker> generatedMarkers = [];
    final List accidentReports = bulkData.reportList;

    for (int i = 0; i < accidentReports.length; i++) {
      double lat = double.parse(accidentReports[i]['latitude']);
      double long = double.parse(accidentReports[i]['longitude']);
      Key uniqueKey = accidentReports[i]['UID'];

      MapMarker mapMarker = MapMarker(point: LatLng(lat, long), key: uniqueKey);

      generatedMarkers.add(mapMarker.createMarker());
    }
    state = MarkerList(generatedMarkers);
  }
}

class MarkerList {
  final List<Marker> markers;

  MarkerList(this.markers);
}

class MapMarker {
  final LatLng point;
  final Key key;
  MapMarker({required this.point, required this.key});

  Marker createMarker() {
    return Marker(
      key: key,
      width: kFocusedMarkerSize + 20,
      height: kFocusedMarkerSize + 20,
      point: point,
      rotate: false,
      builder: (ctx) => IndividualMarker(
        markerKey: key,
        point: point,
      ),
    );
  }
}
