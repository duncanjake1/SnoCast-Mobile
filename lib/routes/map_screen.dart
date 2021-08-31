import 'package:flutter_map/flutter_map.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:native_snocast/components/map_embed.dart';

class MapScreen extends StatelessWidget {
  static const String id = 'map_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('snocast'),
      ),
      backgroundColor: Colors.black,
      body: MapEmbed(),
    );
  }
}
// Hero(
//         tag: 'snowflake',
//         child: SvgPicture.asset(
//           "assets/snowflake.svg",
//           color: Colors.white,
//           height: 70.0,
//         ),
//       ),
