import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:native_snocast/constants.dart';

class MapMarker {
  final double latitude;
  final double longitude;
  final bool isFocused;
  MapMarker(
      {this.latitude = 82.68, this.longitude = 135.00, this.isFocused = false});

  Marker createMarker() {
    // Generate Unique key for each marker
    Key markerKey = UniqueKey();

    return Marker(
      // Generate unique key for each Marker. Used for marker search
      key: markerKey,
      width: kUnfocusedMarkerSize,
      height: kUnfocusedMarkerSize,
      point: LatLng(latitude, longitude),
      rotate: false,
      anchorPos: AnchorPos.exactly(Anchor(1.0, 1.0)),
      builder: (ctx) => IndividualMarker(key: markerKey),
      // TODO: figure out what the anchor point will be (Bottom of pin must always be on location)
      // TODO: must have some sort of state here to update anchor point when the
      // I don't think the above line is needed (I think this can be included in IndividualMarker's state)
      // need to use some kind of widget (think alignment tween) to make marker expand but pin point does not move
    );
  }

  void searchMarkers(List<Marker> markerList) {
    print(markerList[0].builder.toString());
//	for(int i = 0; i < markerList.length; i++){
//		if (markerList[i].builder.toString){
//
//		}
//	}
  }
}

class IndividualMarker extends StatefulWidget {
  // No possible way (as far as I can tell) for key to be null
  final Key? key;
  IndividualMarker({this.key});

  @override
  _IndividualMarkerState createState() => _IndividualMarkerState();
}

class _IndividualMarkerState extends State<IndividualMarker> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          isFocused = !isFocused;
        });
        print(widget.key);
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
