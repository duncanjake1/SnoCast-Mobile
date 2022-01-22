import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:native_snocast/constants.dart';
import 'package:native_snocast/controllers/summary_info_controller.dart';

final currentFocusedMarkerProvider = StateProvider<Key?>((ref) => null);

class IndividualMarker extends ConsumerWidget {
  final Key markerKey;
  final LatLng point;
  IndividualMarker({required this.markerKey, required this.point});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Key? currentFocusedMarkerKey = ref.watch(currentFocusedMarkerProvider);
    bool isFocused = markerKey == currentFocusedMarkerKey;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Key? selectedMarkerKey =
            ref.read(currentFocusedMarkerProvider.notifier).state;
        if (selectedMarkerKey == markerKey) {
          ref.read(currentFocusedMarkerProvider.notifier).state = null;
        } else {
          // OPTION 1: call summary info controller method from here
          // summary info controller would make call to accident report controller and get summary data back
          // if currentFocusedMarkerProvide != null, show summaryDrawer and populate with summary data
          // if currentFocusedMarkerProvide == null, do not make call to accident report controller and ensure summaryDrawer is hidden
          ref.read(currentFocusedMarkerProvider.notifier).state = markerKey;
        }
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
