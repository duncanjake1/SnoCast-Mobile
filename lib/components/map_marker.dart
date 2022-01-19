import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import 'package:flutter/material.dart';
import 'package:native_snocast/constants.dart';
import 'package:native_snocast/main.dart';
import 'package:native_snocast/routes/map_screen.dart';

// used to populate modal data
// state is used to handle toggle

// TODO: I think we may be able too turn this into a stateless widget, and just rebuild when provider updates
class IndividualMarker extends ConsumerStatefulWidget {
  final Key key;
  final LatLng point;
  IndividualMarker({required this.key, required this.point});

  @override
  _IndividualMarkerState createState() => _IndividualMarkerState();
}

class _IndividualMarkerState extends ConsumerState<IndividualMarker> {
  @override
  Widget build(BuildContext context) {
    Key? currentFocusedMarkerKey = ref.watch(currentFocusedMarkerProvider);
    bool isFocused = widget.key == currentFocusedMarkerKey;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          isFocused = widget.key == currentFocusedMarkerKey;
        });
        // also sets currentFocusedMarkerKey to null if widget.key and currentFocusedMarkerKey match
        //currentFocusedMarkerKey = this.key;
        currentFocusedMarkerKey = widget.key;
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
