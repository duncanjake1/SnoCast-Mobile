import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:native_snocast/constants.dart';
import 'package:native_snocast/controllers/map_marker_controller.dart';

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
        point: point,
      ),
    );
  }
}

class IndividualMarker extends StatefulWidget {
  final Key key;
  final LatLng point;
  IndividualMarker({required this.key, required this.point});

  @override
  State<IndividualMarker> createState() => _IndividualMarkerState();
}

class _IndividualMarkerState extends State<IndividualMarker> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    Key? currentFocusedMarkerKey =
        Provider.of<MapMarkerController>(context, listen: false).getCurrentFocusedMarkerKey;
    if (widget.key == currentFocusedMarkerKey) {
      Provider.of<MapMarkerController>(context, listen: false).centerMarkerInMap =
          widget.point;
      setState(() {
        isFocused = true;
      });
    } else {
      setState(() {
        isFocused = false;
      });
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // Set current Marker Key to this widgets key
        // also sets currentFocusedMarkerKey to null if widget.key and currentFocusedMarkerKey match
        Provider.of<MapMarkerController>(context, listen: false)
            .setCurrentFocusedMarkerKey = widget.key;
      },
      child: Container(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            // Marker fill
            Positioned.fill(
              top: isFocused ? -20 : 0,
              child: Icon(
                Icons.location_on_sharp,
                color: Colors.lightBlue,
                size: isFocused ? kFocusedMarkerSize : kUnfocusedMarkerSize,
              ),
            ),
            // Marker outline
            Positioned.fill(
              top: isFocused ? -20 : 0,
              child: Icon(
                Icons.location_on_outlined,
                color: Colors.black,
                size: isFocused ? kFocusedMarkerSize : kUnfocusedMarkerSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
