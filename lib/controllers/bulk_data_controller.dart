import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BulkDataController extends StateNotifier<List<Map>> {
	BulkDataController(): super([]);

  List<Map> _bulkData = [];

  List insertKeysAndUpdateData(List dataSet) {
    // Adds a Unique Identifier to each data point.
    // Neccessary to link map markers to the rest of the data
    for (Map dataPoint in dataSet) {
      dataPoint['UID'] = UniqueKey();
      _bulkData.add(dataPoint);
    }

    return _bulkData;
  }

  UnmodifiableListView get bulkData {
    return UnmodifiableListView(_bulkData);
  }
}
