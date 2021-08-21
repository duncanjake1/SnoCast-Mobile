import 'package:flutter/material.dart';

import 'package:native_snocast/constants.dart';
import 'package:native_snocast/components/animated_shadow.dart';
import 'package:native_snocast/components/animated_snowflake.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'loading_screen';

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLoadingScreenColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSnowflake(),
            AnimatedShadow(),
          ],
        ),
      ),
    );
  }
}
