import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

AudioCache audioCache = AudioCache(prefix: 'audios/');

class HomePage extends StatefulWidget {
  static const wpm = 10;
  static const dot = 1200 ~/ wpm;

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  String message = '';
  DateTime lastTap = DateTime.now();
  AudioPlayer player;

  @override
  void initState() {
    super.initState();
    audioCache.load('beep.mp3');
    audioCache.loop('beep.mp3').then((value) {
      print('done!');
      player = value;
      player.pause();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Text(message)),
            GestureDetector(
              onTapDown: (details) {
                player.resume();
                print('hi');
                lastTap = DateTime.now();
                setState(() {});
              },
              onTapUp: (details) {
                player.pause();
                print('bye');
                final diff = DateTime.now().difference(lastTap);
                if (diff.inMilliseconds <= HomePage.dot) {
                  message += '.';
                } else {
                  message += '-';
                }
                lastTap = DateTime.now();
                Timer(
                  const Duration(milliseconds: 7 * HomePage.dot),
                  () => {
                    if (DateTime.now().difference(lastTap).inMilliseconds >= 7 * HomePage.dot)
                      {setState(() => message += ' ')}
                  },
                );
                setState(() {});
              },
              onTapCancel: () => audioCache.fixedPlayer.pause(),
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
