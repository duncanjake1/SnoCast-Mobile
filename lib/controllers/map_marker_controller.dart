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
  // initialize point here. Point will be updated on marker onFocus
  LatLng _centerPoint = LatLng(37, -108);

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

  set setCurrentFocusedMarkerKey(Key newKey) {
    if (_currentFocusedMarkerKey != newKey) {
      _currentFocusedMarkerKey = newKey;
    } else {
		// deFocus the currently focused marker when pressed again
      _currentFocusedMarkerKey = null;
    }
    notifyListeners();
  }

  Key? get getCurrentFocusedMarkerKey {
    return _currentFocusedMarkerKey;
  }

  set centerMarkerInMap(LatLng point){
	_centerPoint = point;
	notifyListeners();
  }

  LatLng get centerPoint {
	  return _centerPoint;
  }
}
