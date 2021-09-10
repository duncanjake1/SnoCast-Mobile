import 'package:flutter/material.dart';
import 'package:native_snocast/main.dart';
import 'package:provider/provider.dart';

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
        NetworkHelper(url: kBaseURL + kAccidentEndpoint);
    var bulkData = await networkHelper.getData();
    Provider.of<SnoCastData>(context, listen: false).updateData(bulkData);
    // destorys the loading screen and pushes map screen
    // TODO: remove forced delay
    await Future.delayed(
      Duration(seconds: 3),
    );
    if (bulkData[0].keys.first == 'ERR') {
      // TODO: Add text widget that let's user know that connection failed
      print('Exception Handled');
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, MapScreen.id, (route) => false);
    }
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
