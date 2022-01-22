import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/map_marker.dart';

/*
 * if current focused marker == null, do not show the summary info bottom drawer
 * if current focused marker != null, grab summary data from the maker with the selected key
 * 
 * state == null if there is no currently selected marker
 * state == map if there is a currently selected marker
*/

class SummaryInfoStateNotifier extends StateNotifier<SummaryInfo> {
  SummaryInfoStateNotifier(this.ref, [SummaryInfo? summaryInfo])
      : super(summaryInfo ?? SummaryInfo(null));

  // OPTION 2: something like this
  // watch for changes in the currentFocusedMarkerProvider
  // ensuing code will run when state changes

  // Pros: probably better design. using state managment to fuller advantage. less hands on
  // Cons: possibly more confusing if shit goes wrong

  // TODO: Is this even possible this seems more confusing than what we had previously
  // might be worth figuring out a way to keep the ref logic over on the StateNotifierProvider side

  // But I think we can move the reference here
  // will have to pass that through the object creation to here
  // but that has the added benefit of being a bit cleaner and being able to set the state from here
  void funcBoi() {
    final Key? currentSelectedMarker =
        ref.watch(currentFocusedMarkerProvider.notifier).state;

    // change is detected: check if value is null
    if (currentSelectedMarker == null) {
      // value is null: close modal, return empty data set
    } else {
      // value != null: ensure modal is open, call out to accidentSummaryProvider to get summary data
      final SummaryInfo summaryInfo = ref
          .read(accidentReportControllerProvider.notifier)
          .generateSummaryInfo(currentSelectedMarker);
    }
  }

  final StateNotifierProviderRef<SummaryInfoStateNotifier, SummaryInfo> ref;
}

class SummaryInfo {
  final Map? summaryInfo;

  SummaryInfo(this.summaryInfo);
}
