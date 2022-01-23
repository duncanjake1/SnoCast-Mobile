import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:native_snocast/controllers/accident_report_controller.dart';

// TODO: refactor the insertKeys method and use elsewhere
// Might still need bulk data controller to handle divying out data to individual repositories
// But there might be a better way to go about that as well... something to consider
class AccidentReportsListStateNotifier
    extends StateNotifier<AccidentReportsList> {
  AccidentReportsListStateNotifier([AccidentReportsList? reports])
      : super(reports ?? AccidentReportsList([]));

  List<Map> _reports = [];

  void insertKeysAndUpdateData(List dataSet) {
    // Adds a Unique Identifier to each data point.
    // Neccessary to link map markers to the rest of the data
    for (Map dataPoint in dataSet) {
      dataPoint['UID'] = UniqueKey();
      _reports.add(dataPoint);
    }

    state = AccidentReportsList(_reports);
  }

  // this method will only be called if the selectedMarkerKey is not null
  Map generateSummaryInfo(Key selectedMarkerKey) {
    // traverse through bulk data list, grab map with key == selectedMarkerKey
    // return a list containing exactly one map
    final List<Map> accidentData = state.reportList
        .where((Map map) => map['UID'] == selectedMarkerKey)
        .toList();

    return accidentData[0];
  }
}

class AccidentReportsList {
  List<Map> reportList;

  AccidentReportsList(this.reportList);
}
