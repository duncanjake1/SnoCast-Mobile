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
	  //TODO: figure out if we need to change this width and height
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

class IndividualMarker extends StatefulWidget {
  final Key key;
  IndividualMarker({required this.key});

  @override
  State<IndividualMarker> createState() => _IndividualMarkerState();
}

class _IndividualMarkerState extends State<IndividualMarker> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // Call the marker controller to destroy and rebuild widget
		  setState(() {
		    isFocused = !isFocused;
		  });
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
