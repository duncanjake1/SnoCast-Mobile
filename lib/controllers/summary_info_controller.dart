import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/map_marker.dart';

/*
 * if current focused marker == null, do not show the summary info bottom drawer
 * if current focused marker != null, grab summary data from the maker with the selected key
 * 
 * state is null if there is no currently selected marker
 * state is map if there is a currently selected marker
*/

class SummaryInfoStateNotifier extends StateNotifier<SummaryInfo> {
  SummaryInfoStateNotifier(this.read, [SummaryInfo? summaryInfo])
      : super(summaryInfo ?? SummaryInfo(null));

  final Reader read;
  SummaryInfo? generateSummaryData() {
    Key? currentFocusedMarkerKey = read(currentFocusedMarkerProvider);
    print(currentFocusedMarkerKey);

    if (currentFocusedMarkerKey == null) {
      return null;
    }

    // TODO: fill this in w summary data
    // TODO: change variable name
    Map mySpecialDataMap = {};
    return SummaryInfo(mySpecialDataMap);
  }
}

class SummaryInfo {
  final Map? summaryInfo;

  SummaryInfo(this.summaryInfo);
}
