import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedSnowflake extends StatefulWidget {
  @override
  _AnimatedSnowflakeState createState() => _AnimatedSnowflakeState();
}

class _AnimatedSnowflakeState extends State<AnimatedSnowflake> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'snowflake',
      child: SvgPicture.asset(
        "assets/snowflake.svg",
        color: Colors.white,
        height: 200.0,
      ),
    );
  }
}
