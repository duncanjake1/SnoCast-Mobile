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
      builder: (ctx) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          print('hello');
        },
        child: Container(
          // TODO: Refactor stack into IndividualMarker stfl widget
          child: Stack(
            children: [
              // Marker fill
              Positioned.fill(
                child: Icon(
                  Icons.location_on_sharp,
                  color: Colors.lightBlue,
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
      ),
      // TODO: figure out what the anchor point will be (Bottom of pin must always be on location)
      anchorPos: AnchorPos.exactly(Anchor(30, 30)),
    );
  }
}

class IndividualMarker extends StatefulWidget {
  final bool isFocused;
  final VoidCallback? onPressed;

  IndividualMarker({this.onPressed, this.isFocused = false});

  @override
  _IndividualMarkerState createState() => _IndividualMarkerState();
}

class _IndividualMarkerState extends State<IndividualMarker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed!,
    );
  }
}
