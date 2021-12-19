import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:native_snocast/constants.dart';
import 'package:native_snocast/controllers/map_marker_controller.dart';
import 'package:native_snocast/main.dart';


// TODO: I think we may be able too turn this into a stateless widget, and just rebuild when provider updates
class IndividualMarker extends ConsumerStatefulWidget {
  final Key key;
  IndividualMarker({required this.key});

  @override
  _IndividualMarkerState createState() => _IndividualMarkerState();
}

class _IndividualMarkerState extends ConsumerState<IndividualMarker> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
		final markerController = ref.watch(mapMarkerControllerProvider);
    Key? currentFocusedMarkerKey = markerController.getCurrentFocusedMarkerKey;
    if (widget.key == currentFocusedMarkerKey) {
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
        setState(() {
              markerController.setCurrentFocusedMarkerKey = widget.key;
							print(markerController.getCurrentFocusedMarkerKey);
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
