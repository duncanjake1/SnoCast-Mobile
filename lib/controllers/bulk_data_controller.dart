import 'dart:collection';
import 'package:flutter/material.dart';

class BulkDataController extends ChangeNotifier {
  List? _bulkData;

  void updateData(List payload) {
    _bulkData = payload;
    notifyListeners();
  }

  UnmodifiableListView get bulkData {
    if (_bulkData == null) {
      return UnmodifiableListView({});
    } else {
      return UnmodifiableListView(_bulkData!);
    }
  }
}
