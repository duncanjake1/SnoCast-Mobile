import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:native_snocast/constants.dart';
import 'package:native_snocast/types/accident.dart';

class AudioScreen extends ConsumerWidget {
  static const String id = 'audio_screen';
  const AudioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: kLoadingScreenColor,
        ),
        body: Center(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => print('you done started the audio'),
                  child: Text('START AUDIO'),
                ),
                ElevatedButton(
                  onPressed: () => print('you done stopped the audio'),
                  child: Text('STOP AUDIO'),
                ),
              ],
            ),
          ),
        ));
  }
}
