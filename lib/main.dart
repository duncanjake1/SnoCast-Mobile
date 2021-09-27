import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:native_snocast/controllers/bulk_data_controller.dart';
import 'package:native_snocast/controllers/map_marker_controller.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MapMarkerController>(
            create: (context) => MapMarkerController()),
        ChangeNotifierProvider<BulkDataController>(
            create: (context) => BulkDataController()),
      ],
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
