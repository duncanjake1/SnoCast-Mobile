import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../components/map_marker.dart';

class MapMarkerController extends ChangeNotifier {
  List<Marker>? _markerList;

  // create list of map markers
  void generateMapMarkers(List bulkData) {
    List<Marker> mapMarkers = [];
    for (int i = 0; i < bulkData.length; i++) {
      double lat = double.parse(bulkData[i]['latitude']);
      double long = double.parse(bulkData[i]['longitude']);

      MapMarker mapMarker =
          MapMarker(isFocused: false, latitude: lat, longitude: long);

      mapMarkers.add(mapMarker.createMarker());
    }
    _markerList = mapMarkers;
    notifyListeners();
  }

  // return map marker list
  UnmodifiableListView<Marker> get markerList {
    if (_markerList == null) {
      return UnmodifiableListView([]);
    } else {
      return UnmodifiableListView(_markerList!);
    }
  }
}
