import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:native_snocast/controllers/map_marker_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/map_marker.dart';
import 'package:native_snocast/main.dart';

// TODO: implement flutter_map_tile_caching to implement offline features
class MapScreen extends ConsumerWidget {
  static const String id = 'map_screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(currentFocusedMarkerProvider);
    final markerController = ref.watch(mapMarkerControllerProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      // TODO: consider making appbar fully transparent, and surrounding icons in nice looking container
      appBar: AppBar(
        elevation: 0, // removes appbar shadow
        backgroundColor: Color(0x00000000),
        // appbar color gradient
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xFF999999),
                Color(0x00000000),
              ],
            ),
          ),
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
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(37, -108),
          zoom: 4,
          plugins: [
            MarkerClusterPlugin(),
          ],
        ),
        layers: [
          TileLayerOptions(
            //TODO: Change to more pleasant looking map tiles
            urlTemplate: "https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerClusterLayerOptions(
            maxClusterRadius: 45,
            size: Size(40, 40),
            fitBoundsOptions: FitBoundsOptions(
              padding: EdgeInsets.all(50),
            ),
            markers: markerController.markers,
            // Polygon animation is unpleasant. Making it transparent/invisible.
            polygonOptions: PolygonOptions(
                borderColor: Color(0x00000000),
                color: Color(0x00000000),
                borderStrokeWidth: 3),
            // Button for marker cluster
            builder: (context, markers) {
              return Material(
                type: MaterialType.transparency,
                child: Ink(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 4.0),
                    color: Colors.lightBlue,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    //This keeps the splash effect within the circle
                    child: Center(
                      child: Text(
                        markers.length.toString(),
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(1000.0),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
