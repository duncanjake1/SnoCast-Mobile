import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:native_snocast/constants.dart';
import 'package:native_snocast/routes/map_screen.dart';
import 'package:native_snocast/components/summary_bottom_sheet.dart';

final currentFocusedMarkerProvider = StateProvider<Key?>((ref) => null);

class IndividualMarker extends ConsumerWidget {
  final Key markerKey;
  final LatLng point;
  IndividualMarker({required this.markerKey, required this.point});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Key? currentFocusedMarkerKey = ref.watch(currentFocusedMarkerProvider);
    bool isFocused = markerKey == currentFocusedMarkerKey;

    showAccidentSummary() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SummaryBottomSheet();
          }).whenComplete(() {
        // unselect marker on close
        ref.read(currentFocusedMarkerProvider.notifier).state = null;
      });
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Key? selectedMarkerKey =
            ref.read(currentFocusedMarkerProvider.notifier).state;
        if (selectedMarkerKey == markerKey) {
          ref.read(currentFocusedMarkerProvider.notifier).state = null;
        } else {
          ref.read(currentFocusedMarkerProvider.notifier).state = markerKey;
          // TODO: is it buggy to puth this show modal before the get summary data?
          showAccidentSummary();
        }
        ref.read(accidentInfoControllerProvider.notifier).getSummaryData();
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
