import 'package:native_snocast/main.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:native_snocast/constants.dart';
import 'package:native_snocast/main.dart' show SnoCastData;

class MapEmbed extends StatefulWidget {
  @override
  _MapEmbedState createState() => _MapEmbedState();
}

class _MapEmbedState extends State<MapEmbed> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(37, -108),
        zoom: 4,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(
          markers: Provider.of<SnoCastData>(context).getMapMarkerData(),
        ),
      ],
    );
  }
}
