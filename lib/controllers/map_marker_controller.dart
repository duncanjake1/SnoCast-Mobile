import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../components/map_marker.dart';
import 'package:native_snocast/constants.dart';

class MapMarkerController extends ChangeNotifier {
  List<Marker>? _markerList;
  // this key will be use as the 'old marker key'
  // after old marker key has been deactivated, the new key will replace this value
  Key? activatedMarkerKey;

  // create list of map markers
  void generateMapMarkers(List bulkData) {
    List<Marker> mapMarkers = [];
    for (int i = 0; i < bulkData.length; i++) {
      double lat = double.parse(bulkData[i]['latitude']);
      double long = double.parse(bulkData[i]['longitude']);
      Key uniqueKey = bulkData[i]['UID'];

      MapMarker mapMarker =
          MapMarker(isFocused: false, point: LatLng(lat, long), key: uniqueKey);

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
