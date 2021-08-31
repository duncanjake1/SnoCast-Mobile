import 'package:flutter/material.dart';

import 'package:native_snocast/constants.dart';
import 'package:native_snocast/components/animated_snowflake.dart';
import 'package:native_snocast/routes/map_screen.dart';
import 'package:native_snocast/services/networking.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'loading_screen';

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void initState() {
    super.initState();
    getBulkData();
  }

  void getBulkData() async {
    NetworkHelper networkHelper =
        NetworkHelper(url: 'http://10.0.2.2:8000/api/accidents/');
    var bulkData = await networkHelper.getData();
    print(bulkData);
    Navigator.pushNamed(context, MapScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLoadingScreenColor,
      body: Center(
        child: AnimatedSnowflake(),
      ),
    );
  }
}
