import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:native_snocast/routes/loading_screen.dart';
import 'package:native_snocast/routes/map_screen.dart';
import 'components/map_marker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SnoCastData>(
      create: (context) => SnoCastData(),
      child: MaterialApp(
        // initialRoute: LoadingScreen.id,
        debugShowCheckedModeBanner: false,
        initialRoute: LoadingScreen.id,
        routes: {
          LoadingScreen.id: (context) => LoadingScreen(),
          MapScreen.id: (context) => MapScreen(),
        },
      ),
    );
  }
}

// TODO: put this into it's own file
class SnoCastData extends ChangeNotifier {
  List? _bulkData;
  List<Marker>? _markerList;

  void updateData(List payload) {
    _bulkData = payload;
    notifyListeners();
  }

  UnmodifiableListView get bulkData {
    if (_bulkData == null) {
      return UnmodifiableListView({});
    } else {
      return UnmodifiableListView(_bulkData!);
    }
  }

  // create list of map markers
  void generateMapMarkers() {
    List<Marker> mapMarkers = [];
    if (_bulkData != null) {
      for (int i = 0; i < _bulkData!.length; i++) {
        double lat = double.parse(_bulkData![i]['latitude']);
        double long = double.parse(_bulkData![i]['longitude']);

        MapMarker mapMarker =
            MapMarker(isFocused: false, latitude: lat, longitude: long);

        mapMarkers.add(mapMarker.createMarker());
      }
      _markerList = mapMarkers;
      print(_markerList);
      notifyListeners();
    }
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
