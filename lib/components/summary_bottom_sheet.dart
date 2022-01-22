import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:native_snocast/constants.dart';

class SummaryBottomSheet extends StatelessWidget {
  const SummaryBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                "Inbox",
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: Icon(
                                Icons.inbox,
                                color: Colors.white,
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text(
                                "Starred",
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: Icon(
                                Icons.star_border,
                                color: Colors.white,
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text(
                                "Sent",
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text(
                                "Trash",
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: Icon(
                                Icons.delete_outline,
                                color: Colors.white,
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text(
                                "Spam",
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text(
                                "Drafts",
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: Icon(
                                Icons.mail_outline,
                                color: Colors.white,
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      )
                    ],
                  ))),
          Container(
            height: 56,
            color: kSummaryXtraLight,
          )
        ],
      ),
    );
  }
}
