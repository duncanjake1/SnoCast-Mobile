import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:native_snocast/routes/loading_screen.dart';
import 'package:native_snocast/routes/map_screen.dart';
import 'constants.dart';

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

class SnoCastData extends ChangeNotifier {
  List? _bulkData;

  void updateData(List payload) {
    _bulkData = payload;
    print('Bulk data is ... $_bulkData');
    notifyListeners();
  }

  UnmodifiableListView get bulkData {
    if (_bulkData == null) {
      return UnmodifiableListView({});
    } else {
      return UnmodifiableListView(_bulkData!);
    }
  }

  List<Marker> getMapMarkerData() {
    List<Marker> mapMarkers = [];
    if (_bulkData != null) {
      for (int i = 0; i < _bulkData!.length; i++) {
        int key = i;
        double lat = double.parse(_bulkData![i]['latitude']);
        double long = double.parse(_bulkData![i]['longitude']);

        mapMarkers.add(
          Marker(
            width: kUnfocusedMarkerSize,
            height: kUnfocusedMarkerSize,
            point: LatLng(lat, long),
            builder: (ctx) => Container(
              child: Stack(
                children: [
                  // Marker fill
                  Positioned.fill(
                    child: Icon(
                      Icons.location_on_sharp,
                      color: Colors.lightBlue.withOpacity(.8),
                      size: kUnfocusedMarkerSize,
                    ),
                  ),
                  // Marker outline
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.black,
                    size: kUnfocusedMarkerSize,
                  ),
                ],
              ),
            ),
            // TODO: figure out what the anchor point will be (Bottom of pin must always be on location)
            anchorPos: AnchorPos.exactly(Anchor(30, 30)),
          ),
        );
      }
      return mapMarkers;
    } else {
      return [];
    }
  }
}


// theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
