import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:native_snocast/constants.dart';

class MapMarker {
  final int? key;
  final double latitude;
  final double longitude;
  final bool isFocused;

  MapMarker(
      {this.key,
      this.latitude = 82.68,
      this.longitude = 135.00,
      this.isFocused = false});

  Marker createMarker() {
    return Marker(
      width: kUnfocusedMarkerSize,
      height: kUnfocusedMarkerSize,
      point: LatLng(latitude, longitude),
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
    );
  }
}
