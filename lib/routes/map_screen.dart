import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import 'package:native_snocast/controllers/map_marker_controller.dart';
import 'package:native_snocast/components/summary_bottom_sheet.dart';

final mapMarkerControllerProvider =
    StateNotifierProvider<MarkerListStateNotifier, MarkerList>(
        (_) => MarkerListStateNotifier());

// TODO: implement flutter_map_tile_caching to implement offline features
class MapScreen extends ConsumerWidget {
  static const String id = 'map_screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markerController = ref.watch(mapMarkerControllerProvider);

    showMenu() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SummaryBottomSheet();
          });
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      // TODO: consider making appbar fully transparent, and surrounding icons in nice looking container
      appBar: AppBar(
        elevation: 0, // removes appbar shadow
        backgroundColor: Color(0x00000000),
        // appbar color gradient
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xFF999999),
                Color(0x00000000),
              ],
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            tag: 'snowflake',
            child: SvgPicture.asset(
              "assets/snowflake.svg",
              color: Colors.white,
              height: 70.0,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Color(0xff344955),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          height: 56.0,
          child: Row(children: <Widget>[
            IconButton(
              onPressed: showMenu,
              icon: Icon(Icons.menu),
              color: Colors.white,
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
              color: Colors.white,
            )
          ]),
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
          zoom: 4,
          center: LatLng(37, -108),
          plugins: [
            MarkerClusterPlugin(),
          ],
        ),
        layers: [
          TileLayerOptions(
            //TODO: Change to more pleasant looking map tiles
            urlTemplate: "https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerClusterLayerOptions(
            maxClusterRadius: 45,
            size: Size(40, 40),
            fitBoundsOptions: FitBoundsOptions(
              padding: EdgeInsets.all(50),
            ),
            markers: markerController.markers,
            // Polygon animation is unpleasant. Making it transparent/invisible.
            polygonOptions: PolygonOptions(
                borderColor: Color(0x00000000),
                color: Color(0x00000000),
                borderStrokeWidth: 3),
            // Button for marker cluster
            builder: (context, markers) {
              return Material(
                type: MaterialType.transparency,
                child: Ink(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 4.0),
                    color: Colors.lightBlue,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    //This keeps the splash effect within the circle
                    child: Center(
                      child: Text(
                        markers.length.toString(),
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(1000.0),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      //TODO: remove this bottomBar
      // bottomNavigationBar: BottomAppBar(
      //   elevation: 0,
      //   color: Color(0xff344955),
      //   child: Container(
      //     padding: EdgeInsets.symmetric(horizontal: 10.0),
      //     height: 56.0,
      //     child: Row(children: <Widget>[
      //       IconButton(
      //         onPressed: showMenu,
      //         icon: Icon(Icons.menu),
      //         color: Colors.white,
      //       ),
      //       Spacer(),
      //       IconButton(
      //         onPressed: () {},
      //         icon: Icon(Icons.add),
      //         color: Colors.white,
      //       )
      //     ]),
      //   ),
      // ),
    );
  }
}


// TODO: finish this
// slide up modal example

//      bottomNavigationBar: BottomAppBar(
//        elevation: 0,
//        color: Color(0xff344955),
//        child: Container(
//          padding: EdgeInsets.symmetric(horizontal: 10.0),
//          height: 56.0,
//          child: Row(children: <Widget>[
//            IconButton(
//              onPressed: showMenu,
//              icon: Icon(Icons.menu),
//              color: Colors.white,
//            ),
//            Spacer(),
//            IconButton(
//              onPressed: () {},
//              icon: Icon(Icons.add),
//              color: Colors.white,
//            )
//          ]),
//        ),
//      ),
//  showMenu() {
//    showModalBottomSheet(
//        context: context,
//        builder: (BuildContext context) {
//          return Container(
//            decoration: BoxDecoration(
//              borderRadius: BorderRadius.only(
//                topLeft: Radius.circular(16.0),
//                topRight: Radius.circular(16.0),
//              ),
//              color: Color(0xff232f34),
//            ),
//            child: Column(
//              mainAxisSize: MainAxisSize.min,
//              crossAxisAlignment: CrossAxisAlignment.end,
//              children: <Widget>[
//                Container(
//                  height: 36,
//                ),
//                SizedBox(
//                    height: (56 * 6).toDouble(),
//                    child: Container(
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.only(
//                            topLeft: Radius.circular(16.0),
//                            topRight: Radius.circular(16.0),
//                          ),
//                          color: Color(0xff344955),
//                        ),
//                        child: Stack(
//                          alignment: Alignment(0, 0),
//                          overflow: Overflow.visible,
//                          children: <Widget>[
//                            Positioned(
//                              top: -36,
//                              child: Container(
//                                decoration: BoxDecoration(
//                                    borderRadius:
//                                        BorderRadius.all(Radius.circular(50)),
//                                    border: Border.all(
//                                        color: Color(0xff232f34), width: 10)),
//                                child: Center(
//                                  child: ClipOval(
//                                    child: Image.network(
//                                      "https://i.stack.imgur.com/S11YG.jpg?s=64&g=1",
//                                      fit: BoxFit.cover,
//                                      height: 36,
//                                      width: 36,
//                                    ),
//                                  ),
//                                ),
//                              ),
//                            ),
//                            Positioned(
//                              child: ListView(
//                                physics: NeverScrollableScrollPhysics(),
//                                children: <Widget>[
//                                  ListTile(
//                                    title: Text(
//                                      "Inbox",
//                                      style: TextStyle(color: Colors.white),
//                                    ),
//                                    leading: Icon(
//                                      Icons.inbox,
//                                      color: Colors.white,
//                                    ),
//                                    onTap: () {},
//                                  ),
//                                  ListTile(
//                                    title: Text(
//                                      "Starred",
//                                      style: TextStyle(color: Colors.white),
//                                    ),
//                                    leading: Icon(
//                                      Icons.star_border,
//                                      color: Colors.white,
//                                    ),
//                                    onTap: () {},
//                                  ),
//                                  ListTile(
//                                    title: Text(
//                                      "Sent",
//                                      style: TextStyle(color: Colors.white),
//                                    ),
//                                    leading: Icon(
//                                      Icons.send,
//                                      color: Colors.white,
//                                    ),
//                                    onTap: () {},
//                                  ),
//                                  ListTile(
//                                    title: Text(
//                                      "Trash",
//                                      style: TextStyle(color: Colors.white),
//                                    ),
//                                    leading: Icon(
//                                      Icons.delete_outline,
//                                      color: Colors.white,
//                                    ),
//                                    onTap: () {},
//                                  ),
//                                  ListTile(
//                                    title: Text(
//                                      "Spam",
//                                      style: TextStyle(color: Colors.white),
//                                    ),
//                                    leading: Icon(
//                                      Icons.error,
//                                      color: Colors.white,
//                                    ),
//                                    onTap: () {},
//                                  ),
//                                  ListTile(
//                                    title: Text(
//                                      "Drafts",
//                                      style: TextStyle(color: Colors.white),
//                                    ),
//                                    leading: Icon(
//                                      Icons.mail_outline,
//                                      color: Colors.white,
//                                    ),
//                                    onTap: () {},
//                                  ),
//                                ],
//                              ),
//                            )
//                          ],
//                        ))),
//                Container(
//                  height: 56,
//                  color: Color(0xff4a6572),
//                )
//              ],
//            ),
//          );
//        });
//  }
//}
