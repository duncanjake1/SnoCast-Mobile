import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:native_snocast/routes/map_screen.dart';
import 'package:native_snocast/routes/audio_screen.dart';
import 'package:native_snocast/constants.dart';

class SummaryBottomSheet extends ConsumerWidget {
  const SummaryBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accidentData =
        ref.read(accidentInfoControllerProvider.notifier).state.accidentData;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
        color: kSummaryDark,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            height: 36,
          ),
          SizedBox(
            height: (56 * 6).toDouble(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                color: kSummaryLight,
              ),
              child: Stack(
                alignment: Alignment(0, 0),
                clipBehavior: Clip.none,
                children: <Widget>[
                  Positioned(
                    top: -36,
                    child: Container(
                      decoration: BoxDecoration(
                        color: kSummaryDark,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.all(
                          color: kSummaryDark,
                          width: 10,
                        ),
                      ),
                      child: Center(
                        child: ClipOval(
                          child: SvgPicture.asset(
                            "assets/snowflake.svg",
                            color: Colors.white,
                            height: 75.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: accidentData != null
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.all(0),
                                        minLeadingWidth: 0,
                                        horizontalTitleGap: 8,
                                        leading: Icon(
                                          Icons.date_range_sharp,
                                        ),
                                        title: Text(
                                          accidentData.date,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.all(0),
                                        minLeadingWidth: 0,
                                        horizontalTitleGap: 8,
                                        leading: Icon(
                                          Icons.location_on_sharp,
                                        ),
                                        title: Text(
                                          accidentData.state,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  minLeadingWidth: 0,
                                  horizontalTitleGap: 8,
                                  leading: Icon(Icons.warning_sharp),
                                  title: Text(
                                    accidentData.summaryDescription,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  minLeadingWidth: 0,
                                  horizontalTitleGap: 8,
                                  leading: Icon(Icons.landscape_sharp),
                                  title: Text(
                                    accidentData.location,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  minLeadingWidth: 0,
                                  horizontalTitleGap: 8,
                                  leading: Icon(Icons.ac_unit_sharp),
                                  title: Text(
                                    'Primary Activity: ${accidentData.primaryActivity}',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  minLeadingWidth: 0,
                                  horizontalTitleGap: 8,
                                  leading: Icon(Icons.moving_sharp),
                                  title: Text(
                                    'Travel Mode: ${accidentData.primaryTravelMode}',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () => Navigator.pushNamed(
                                        context, AudioScreen.id),
                                    child: Text('GET AUDIO'),
                                  ),
                                )
                              ],
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Something happened and we could not find the data you\'re looking for.',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 15.0),
                                  Text(
                                    'Please close this slide up and try again.',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 30,
            color: kSummaryXtraLight,
          )
        ],
      ),
    );
  }
}
