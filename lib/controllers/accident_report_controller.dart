import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:native_snocast/controllers/summary_info_controller.dart';

// TODO: refactor the insertKeys method and use elsewhere
// Might still need bulk data controller to handle divying out data to individual repositories
// But there might be a better way to go about that as well... something to consider
class AccidentReportsStateNotifier extends StateNotifier<AccidentReports> {
  AccidentReportsStateNotifier([AccidentReports? reports])
      : super(reports ?? AccidentReports([]));

  List<Map> _reports = [];

  void insertKeysAndUpdateData(List dataSet) {
    // Adds a Unique Identifier to each data point.
    // Neccessary to link map markers to the rest of the data
    for (Map dataPoint in dataSet) {
      dataPoint['UID'] = UniqueKey();
      _reports.add(dataPoint);
    }

    state = AccidentReports(_reports);
  }

  SummaryInfo generateSummaryInfo(Key selectedMarkerKey) {
    // TODO: filter through state to get summary related info
    // this method will only be called if the selectedMarkerKey is not null
    return SummaryInfo({});
  }
}

class AccidentReports {
  List<Map> reportList;

  AccidentReports(this.reportList);
}
