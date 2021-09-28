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

      MapMarker mapMarker = MapMarker(
          isFocused: false, point: LatLng(lat, long), key: UniqueKey());

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

  void toggleFocus(Key pressedMarkerKey) {
    if (_markerList != null) {
      for (int i = 0; i < _markerList!.length; i++) {
        if (_markerList![i].key == activatedMarkerKey) {
          // Old marker recreated as unfocused
          recreateMarker(index: i, setFocused: false);
          print('I have been reborn a small boy');
        } else if (pressedMarkerKey == _markerList![i].key) {
          // new marker recreated as focused
          recreateMarker(index: i, setFocused: true);
          print('I have been reborn a large boy');
        }
      }
      // update value of activatedMarkerKey
      activatedMarkerKey = pressedMarkerKey;
    } else {
      // TODO: do something about this
      print('data is null sowwwyyyyyy');
    }
  }

  void recreateMarker({required int index, required bool setFocused}) {
    Marker oldMarker = _markerList![index];
    //Create new marker
    MapMarker newMapMarker = MapMarker(
        isFocused: setFocused, point: oldMarker.point, key: oldMarker.key!);
    Marker newMarker = newMapMarker.createMarker();
    // Destroy old marker
    _markerList!.removeAt(index);
    // Place new Marker in List
    _markerList!.add(newMarker);
  }
}
