import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:native_snocast/constants.dart';
import 'package:native_snocast/controllers/map_marker_controller.dart';

class MapMarker {
  final bool isFocused;
  final LatLng point;
  final Key key;
  // define default values (prevent null)
  MapMarker({required this.isFocused, required this.point, required this.key});

  Marker createMarker() {
    return Marker(
      key: key,
      width: isFocused ? kFocusedMarkerSize : kUnfocusedMarkerSize,
      height: isFocused ? kFocusedMarkerSize : kUnfocusedMarkerSize,
      point: point,
      rotate: false,
      anchorPos: AnchorPos.exactly(Anchor(1.0, 1.0)),
      builder: (ctx) => IndividualMarker(
        isFocused: isFocused,
        key: key,
      ),
      // TODO: figure out what the anchor point will be (Bottom of pin must always be on location)
      // TODO: must have some sort of state here to update anchor point when the
      // I don't think the above line is needed (I think this can be included in IndividualMarker's state)
      // need to use some kind of widget (think alignment tween) to make marker expand but pin point does not move
    );
  }
}

class IndividualMarker extends StatelessWidget {
  final bool isFocused;
  final Key key;
  IndividualMarker({required this.isFocused, required this.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // Call the marker controller to destroy and rebuild widget
        print('pressed me');
      },
      child: Container(
        child: Stack(
          children: [
            // Marker fill
            Positioned.fill(
              child: Icon(
                Icons.location_on_sharp,
                color: Colors.lightBlue,
                size: isFocused ? kFocusedMarkerSize : kUnfocusedMarkerSize,
              ),
            ),
            // Marker outline
            Icon(
              Icons.location_on_outlined,
              color: Colors.black,
              size: isFocused ? kFocusedMarkerSize : kUnfocusedMarkerSize,
            ),
          ],
        ),
      ),
    );
  }
}
