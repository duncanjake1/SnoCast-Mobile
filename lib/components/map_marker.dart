import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:native_snocast/constants.dart';

class MarkerLIst {
  final double? latitude;
  final double? longitude;
  bool? isFocused;

  MarkerLIst({this.latitude, this.longitude, this.isFocused});

  Marker createMarker() {
    return Marker(
      width: kUnfocusedMarkerSize,
      height: kUnfocusedMarkerSize,
      point: LatLng(37, -108),
      builder: (ctx) => Container(
        child: Icon(
          Icons.location_on_sharp,
          color: Colors.lightBlue,
          size: kUnfocusedMarkerSize,
        ),
      ),
      // TODO: figure out what the anchor point will be (Bottom of pin must always be on location)
      anchorPos: AnchorPos.exactly(Anchor(30, 30)),
    );
  }
}
