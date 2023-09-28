// ignore_for_file: library_private_types_in_public_api

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerScreen extends StatefulWidget {
  final String audioAssetPath;

  const AudioPlayerScreen({
    Key? key,
    required this.audioAssetPath,
  }) : super(key: key);

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  double sliderValue = 0.0;
  Duration totalDuration = const Duration();
  Duration currentPosition = const Duration();

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed) {
        // Audio playback completed
        setState(() {
          isPlaying = false;
          sliderValue = 0.0;
          currentPosition = const Duration(); // Reset to the beginning
        });
      }
    });

    audioPlayer.onDurationChanged.listen((Duration duration) {
      // Set the total duration when it changes
      setState(() {
        totalDuration = duration;
      });
    });

    audioPlayer.onPositionChanged.listen((Duration duration) {
      // Update the current position
      setState(() {
        currentPosition = duration;
        sliderValue = currentPosition.inMilliseconds.toDouble() /
            totalDuration.inMilliseconds.toDouble();
      });
    });
  }

  Future<void> _playAudio() async {
    if (isPlaying) {
      // If audio is already playing, pause it
      await audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      // If audio is not playing, start playing it
      await audioPlayer.play(
        AssetSource(widget.audioAssetPath),
        position: currentPosition, // Start from the current position
      );
      setState(() {
        isPlaying = true;
      });
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${currentPosition.inMinutes}:${(currentPosition.inSeconds % 60).toString().padLeft(2, '0')} / '
              '${totalDuration.inMinutes}:${(totalDuration.inSeconds % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Slider(
              value: sliderValue,
              onChanged: (double value) {
                final newPosition =
                    value * totalDuration.inMilliseconds.toDouble();
                audioPlayer.seek(Duration(milliseconds: newPosition.toInt()));
                setState(() {
                  currentPosition = Duration(milliseconds: newPosition.toInt());
                  sliderValue = value;
                });
              },
              thumbColor: Colors.white,
              activeColor: Colors.white,
              inactiveColor: Colors.blueGrey,
            ),
            IconButton(
              icon: isPlaying
                  ? const Icon(
                      Icons.pause_circle_outlined,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.play_circle_outline,
                      color: Colors.white,
                    ),
              iconSize: 48,
              onPressed: _playAudio,
            ),
          ],
        ),
      ),
    );
  }
}
