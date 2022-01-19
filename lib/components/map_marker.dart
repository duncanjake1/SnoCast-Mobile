import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:native_snocast/constants.dart';
import 'package:native_snocast/routes/map_screen.dart';

final _currentFocusedMarkerProvider = StateProvider<Key>((ref) => UniqueKey());

// TODO: I think we may be able too turn this into a stateless widget, and just rebuild when provider updates
class IndividualMarker extends ConsumerWidget {
  final Key key;
  final LatLng point;
  IndividualMarker({required this.key, required this.point});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Key currentFocusedMarkerKey = ref.watch(_currentFocusedMarkerProvider);
    bool isFocused = key == currentFocusedMarkerKey;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        ref.read(_currentFocusedMarkerProvider.notifier).state = key;
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
