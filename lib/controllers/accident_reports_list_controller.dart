import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:native_snocast/types/accident.dart';

// TODO: refactor the insertKeys method and use elsewhere
// Might still need bulk data controller to handle divying out data to individual repositories
// But there might be a better way to go about that as well... something to consider
class AccidentReportsListStateNotifier
    extends StateNotifier<AccidentReportsList> {
  AccidentReportsListStateNotifier([AccidentReportsList? reports])
      : super(reports ?? AccidentReportsList([]));

  List<Map> _reports = [];

  void setState(List<Accident> dataSet) {
    state = AccidentReportsList(dataSet);
  }

  // this method will only be called if the selectedMarkerKey is not null
  Accident generateSummaryInfo(Key selectedMarkerKey) {
    // traverse through bulk data list, grab map with key == selectedMarkerKey
    // return a list containing exactly one map
    final List<Accident> accidentData = state.reportList
        .where((Accident map) => map.key == selectedMarkerKey)
        .toList();

    return accidentData[0];
  }
}

class AccidentReportsList {
  List<Accident> reportList;

  AccidentReportsList(this.reportList);
}
