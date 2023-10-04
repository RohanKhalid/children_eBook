// ignore_for_file: library_private_types_in_public_api

import 'package:ebook/animations/back_page_animation.dart';
import 'package:ebook/animations/forward_page_animation.dart';
import 'package:ebook/screens/hmong_dwab/scene_1.dart';
import 'package:ebook/screens/hmong_dwab/scene_3.dart';
import 'package:ebook/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart'; // Import the audioplayers package

class SceneD2 extends StatefulWidget {
  const SceneD2({Key? key}) : super(key: key);

  @override
  _SceneD2State createState() => _SceneD2State();
}

class _SceneD2State extends State<SceneD2> {
  late AudioPlayer audioPlayer; // Create an instance of AudioPlayer
  late AudioPlayer
      backgroundAudioPlayer; // Audio player for the background track

  @override
  void initState() {
    super.initState();

    // Initialize the audio players
    audioPlayer = AudioPlayer();
    backgroundAudioPlayer = AudioPlayer();

    // Play the current audio track
    playAudio('hmong_dwab_audio/scene_2.m4a');

    // Play the background audio track and set it to loop continuously
    playBackgroundAudio('background_audio/scene_2.mp3');
    backgroundAudioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  // Function to play the current audio track
  Future<void> playAudio(String audioPath) async {
    await audioPlayer.play(
      AssetSource(audioPath),
    );
  }

  // Function to play the background audio track
  Future<void> playBackgroundAudio(String backgroundAudioPath) async {
    await backgroundAudioPlayer.play(
      AssetSource(backgroundAudioPath),
    );
  }

  // Function to stop the current audio track
  Future<void> stopAudio() async {
    await audioPlayer.stop();
  }

  // Function to stop the background audio track
  Future<void> stopBackgroundAudio() async {
    await backgroundAudioPlayer.stop();
  }

  @override
  void dispose() {
    // Dispose of the audioPlayer when the widget is disposed
    audioPlayer.dispose();
    backgroundAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/hmong_dwab/scene_2.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Positioned(
            top: screenHeight * 0.1,
            right: screenHeight * 0.7,
            child: Container(
              color: Colors.transparent,
              height: 200,
              width: 200,
              // No need to explicitly add the AudioPlayerScreen here
            ),
          ),
          Positioned(
            top: screenHeight * 0.01,
            right: screenHeight * 0.01,
            child: GestureDetector(
              onTap: () {
                stopAudio();
                stopBackgroundAudio(); // Stop the background audio track
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: Container(
                width: screenHeight * 0.2,
                height: screenHeight * 0.2,
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.4,
            right: screenHeight * 0.01,
            child: GestureDetector(
              onTap: () {
                stopAudio();
                stopBackgroundAudio(); // Stop the background audio track
                Navigator.of(context).push(
                  SlideRightPageRoute(
                    page: const SceneD3(),
                  ),
                );
              },
              child: Container(
                width: screenHeight * 0.2,
                height: screenHeight * 0.2,
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.4,
            left: screenHeight * 0.01,
            child: GestureDetector(
              onTap: () {
                stopAudio();
                stopBackgroundAudio(); // Stop the background audio track
                Navigator.of(context).push(
                  SlideRightPageRouteB(
                    page: const SceneD1(),
                  ),
                );
              },
              child: Container(
                width: screenHeight * 0.2,
                height: screenHeight * 0.2,
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
