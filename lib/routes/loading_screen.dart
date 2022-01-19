import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:native_snocast/constants.dart';
import 'package:native_snocast/components/animated_snowflake.dart';
import 'package:native_snocast/routes/map_screen.dart';
import 'package:native_snocast/services/networking.dart';
import 'package:native_snocast/controllers/bulk_data_controller.dart';


class LoadingScreen extends ConsumerStatefulWidget {
  static const String id = 'loading_screen';

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  bool connectionIsRetrying = false;

  void initState() {
    super.initState();
    getBulkData(ref);
  }

  void getBulkData(WidgetRef ref) async {
    NetworkHelper networkHelper =
        NetworkHelper(url: kBaseURL + kAccidentEndpoint);
    var bulkData = await networkHelper.getData();

    List bulkDataWithKeys =
        BulkDataController().insertKeysAndUpdateData(bulkData);
    if (bulkData[0].keys.first == 'ERR') {
      showConnectionError();
    } else {
      // build map markers off of bulk data with keys, then push to new screen
      ref
          .read(mapMarkerControllerProvider.notifier)
          .generateMapMarkers(bulkDataWithKeys);
      // providerName.generateMapMarkers(bulkDataWithKeys);
      // destorys the loading screen and pushes map screen
      Navigator.pushNamedAndRemoveUntil(
          context, MapScreen.id, (route) => false);
    }
  }

  void showConnectionError() {
    setState(() {
      // ensure 'Retrying...' message is hidden
      connectionIsRetrying = false;
    });

    // TODO: refactor to snackbar
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Unable to connect to server'),
                ElevatedButton(
                  child: const Text('Try again?'),
                  onPressed: () {
                    setState(() {
                      // shows 'Retrying...' text
                      connectionIsRetrying = true;
                    });
                    // Retry connection
                    getBulkData(ref);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLoadingScreenColor,
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 30),
            child: Text(
              'Retrying...',
              style: TextStyle(
                color:
                    connectionIsRetrying ? Colors.white : kLoadingScreenColor,
                fontSize: 35,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Center(
            child: AnimatedSnowflake(),
          ),
        ],
      ),
    );
  }
}
