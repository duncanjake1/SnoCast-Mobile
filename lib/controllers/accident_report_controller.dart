import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/map_marker.dart';
import 'package:native_snocast/routes/loading_screen.dart';

/*
 * if current focused marker == null, do not show the summary info bottom drawer
 * if current focused marker != null, grab summary data from the maker with the selected key
 * 
 * state == null if there is no currently selected marker
 * state == map if there is a currently selected marker
 */

class AccidentReportStateNotifier extends StateNotifier<AccidentReport> {
  AccidentReportStateNotifier(this.read, [AccidentReport? summaryInfo])
      : super(summaryInfo ?? AccidentReport(null));

  final Reader read;

  /*
   * Method is called when a map marker is tapped
   *
   * This method calls the AccidentReportsListStateNotifier
   * which handles filtering and returning the summary specific info
   *
   * This logic could be handled directly by calling AccidentReportsListStateNotifier directly
   * BUT: That would mean setting the state of this StateNotifier from another StateNotifier
   * I deemed it more logical to let this StateNotifier handle setting its own state
   * It also makes a little more sense to call this provider when we want to get summary info
   */
  void getSummaryData() {
    final Key? currentSelectedMarker =
        read(currentFocusedMarkerProvider.notifier).state;

    if (currentSelectedMarker == null) {
      state = AccidentReport(null);
    } else {
      final Map summaryInfo = read(accidentReportControllerProvider.notifier)
          .generateSummaryInfo(currentSelectedMarker);

      state = AccidentReport(summaryInfo);
    }
  }
}

/* 
state == null : ensure summary info bottomDrawer is hidden
state != null : populate and show the summary info bottomDrawer
*/
class AccidentReport {
  final Map? accidentData;

  AccidentReport(this.accidentData);
}
