import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:native_snocast/constants.dart';
import 'package:native_snocast/controllers/summary_info_controller.dart';

final currentFocusedMarkerProvider = StateProvider<Key?>((ref) => null);

class IndividualMarker extends ConsumerWidget {
  final Key key;
  final LatLng point;
  IndividualMarker({required this.key, required this.point});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Key? currentFocusedMarkerKey = ref.watch(currentFocusedMarkerProvider);
    bool isFocused = key == currentFocusedMarkerKey;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        ref.read(currentFocusedMarkerProvider.notifier).state = key;
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
