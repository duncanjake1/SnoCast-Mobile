import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:native_snocast/main.dart' show SnoCastData;

class MapScreen extends StatelessWidget {
  static const String id = 'map_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // elevation = 0 gets rid of appBar shadow
        elevation: 0,
        backgroundColor: Color(0x00000000),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xFF999999),
              Color(0x00000000),
            ],
          )),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            tag: 'snowflake',
            child: SvgPicture.asset(
              "assets/snowflake.svg",
              color: Colors.white,
              height: 70.0,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: FlutterMap(
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
      ),
    );
  }
}
