import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/map_marker.dart';
import 'package:native_snocast/constants.dart';

class MarkerListStateNotifier extends StateNotifier<MarkerList> {
  MarkerListStateNotifier([MarkerList? markerList])
      : super(markerList ?? MarkerList([]));

  void generateMapMarkers(List bulkData) {
		List<Marker> generatedMarkers = [];
    for (int i = 0; i < bulkData.length; i++) {
      double lat = double.parse(bulkData[i]['latitude']);
      double long = double.parse(bulkData[i]['longitude']);
      Key uniqueKey = bulkData[i]['UID'];

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
        key: key,
      ),
    );
  }
}

class CurrentFocusedMarkerStateNotifier
    extends StateNotifier<CurrentFocusedMarker> {
  CurrentFocusedMarkerStateNotifier(
      CurrentFocusedMarker? currentFocusedMarkerKey)
      : super(currentFocusedMarkerKey ?? CurrentFocusedMarker(null));

  set setCurrentFocusedMarkerKey(Key newKey) {
    if (state.focusedMarkerKey != newKey) {
      state = CurrentFocusedMarker(newKey);
    } else {
      // deFocus the currently focused marker when pressed again
      state = CurrentFocusedMarker(null);
    }
  }
}

class CurrentFocusedMarker {
  final Key? focusedMarkerKey;

  CurrentFocusedMarker(this.focusedMarkerKey);
}

