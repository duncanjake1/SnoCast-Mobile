import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:native_snocast/controllers/map_marker_controller.dart';
import 'package:native_snocast/controllers/bulk_data_controller.dart';

import 'package:native_snocast/routes/loading_screen.dart';
import 'package:native_snocast/routes/map_screen.dart';

final bulkDataControllerProvider = StateProvider<BulkDataController>((_) => BulkDataController());
final mapMarkerControllerProvider = StateProvider<MapMarkerController>((_) => MapMarkerController());

void main() {
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: LoadingScreen.id,
      debugShowCheckedModeBanner: false,
      initialRoute: LoadingScreen.id,
      routes: {
        LoadingScreen.id: (context) => LoadingScreen(),
        MapScreen.id: (context) => MapScreen(),
      },
    );
  }
}

