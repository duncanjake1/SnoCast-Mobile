import 'package:flutter/material.dart';

import 'package:native_snocast/constants.dart';

class AnimatedShadow extends StatefulWidget {
  @override
  _AnimatedShadowState createState() => _AnimatedShadowState();
}

class _AnimatedShadowState extends State<AnimatedShadow> {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        color: kSnowflakeShadowColor,
        height: 100.0,
        width: 250.0,
      ),
    );
  }
}
