import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:native_snocast/constants.dart';
import 'package:native_snocast/main.dart';

final currentFocusedMarkerProvider = StateProvider<Key?>((_) => null);

// TODO: I think we may be able too turn this into a stateless widget, and just rebuild when provider updates
// we probably need a local provider for this. currentFocusedMarkerKeyProvider or something
class IndividualMarker extends ConsumerWidget {
  final Key key;
  IndividualMarker({required this.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Key? currentFocusedMarkerKey = ref.watch(currentFocusedMarkerProvider);
    bool isFocused = this.key == currentFocusedMarkerKey;

    print('marker says');
    print(this.key);
    print('provider says');
    print(currentFocusedMarkerKey);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // Set current Marker Key to this widgets key
        // also sets currentFocusedMarkerKey to null if widget.key and currentFocusedMarkerKey match
        currentFocusedMarkerKey = this.key;
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
