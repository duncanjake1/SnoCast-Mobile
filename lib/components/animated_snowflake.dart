import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:native_snocast/constants.dart';
import 'dart:math';

class AnimatedSnowflake extends StatefulWidget {
  @override
  _AnimatedSnowflakeState createState() => _AnimatedSnowflakeState();
}

class _AnimatedSnowflakeState extends State<AnimatedSnowflake>
    with TickerProviderStateMixin {
  late AnimationController rotationController;
  late AnimationController bounceController;
  late Animation bounceAnimation;
  late Animation<double> easeAnimationCurve;

  void initState() {
    super.initState();

    // initialize controllers
    rotationController = AnimationController(
      duration: kRotationAnimationDuration,
      vsync: this,
      upperBound: pi * 2,
    );

    bounceController = AnimationController(
      vsync: this,
      duration: kBounceAnimationDuration,
      upperBound: 1,
    );

    // set initial controller directions and add listeners
    rotationController.forward();
    rotationController.addListener(
      () {
        setState(() {
          if (rotationController.status == AnimationStatus.completed) {
            rotationController.repeat();
          }
        });
      },
    );

    bounceController.forward();
    bounceController.addListener(() {
      setState(() {});
      if (bounceController.value == 1) {
        bounceController.reverse();
      } else if (bounceController.value == 0) {
        bounceController.forward();
      }
    });

    // add animation curve to tween
    // this curve is applied to both bounce and shadow
    easeAnimationCurve = bounceController.drive(
      CurveTween(curve: Curves.easeInOut),
    );
    bounceAnimation =
        AlignmentTween(begin: Alignment(0.0, 0.0), end: Alignment(0.0, 1.0))
            .animate(
      easeAnimationCurve,
    );
  }

  void dispose() {
    rotationController.dispose();
    bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: bounceAnimation.value,
          height: 300,
          child: Transform.rotate(
            angle: rotationController.value,
            child: Hero(
              tag: 'snowflake',
              child: SvgPicture.asset(
                "assets/snowflake.svg",
                color: Colors.white,
                height: 200.0,
              ),
            ),
          ),
        ),
        ClipOval(
          child: Container(
            color: kSnowflakeShadowColor,
            height: 40.0,
            width: easeAnimationCurve.value * 40 + 150,
          ),
        )
      ],
    );
  }
}
