import 'dart:collection';
import 'package:flutter/material.dart';

class BulkDataController extends ChangeNotifier {
  List<Map> _bulkData = [];

  List insertKeysAndUpdateData(List dataSet) {
    // Adds a Unique Identifier to each data point.
    // Neccessary to link map markers to the rest of the data
    for (Map dataPoint in dataSet) {
      dataPoint['UID'] = UniqueKey();
      _bulkData.add(dataPoint);
    }
    notifyListeners();
    return _bulkData;
  }

  UnmodifiableListView get bulkData {
    return UnmodifiableListView({});
  }
}
