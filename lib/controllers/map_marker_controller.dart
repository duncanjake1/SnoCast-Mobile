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
  Key? _currentFocusedMarkerKey;

  // create list of map markers
  void generateMapMarkers(List bulkData) {
    List<Marker> mapMarkers = [];
    for (int i = 0; i < bulkData.length; i++) {
      double lat = double.parse(bulkData[i]['latitude']);
      double long = double.parse(bulkData[i]['longitude']);
      Key uniqueKey = bulkData[i]['UID'];

      MapMarker mapMarker = MapMarker(point: LatLng(lat, long), key: uniqueKey);

      mapMarkers.add(mapMarker.createMarker());
    }
    _markerList = mapMarkers;

    // TODO: got rid of notifyListeners. ensure this works
  }

  // return map marker list
  UnmodifiableListView<Marker> get markerList {
    if (_markerList == null) {
      return UnmodifiableListView([]);
    } else {
      return UnmodifiableListView(_markerList!);
    }
  }

  set setCurrentFocusedMarkerKey(Key newKey) {
    if (_currentFocusedMarkerKey != newKey) {
      _currentFocusedMarkerKey = newKey;
    } else {
      // deFocus the currently focused marker when pressed again
      _currentFocusedMarkerKey = null;
    }
    // TODO: got rid of notifyListeners. ensure this works
  }

  Key? get getCurrentFocusedMarkerKey {
    return _currentFocusedMarkerKey;
  }
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
        key: key,
      ),
    );
  }
}
