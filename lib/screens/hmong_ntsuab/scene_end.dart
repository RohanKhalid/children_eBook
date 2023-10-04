// ignore_for_file: library_private_types_in_public_api

import 'package:audioplayers/audioplayers.dart';
import 'package:ebook/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Sceneend extends StatefulWidget {
  const Sceneend({Key? key}) : super(key: key);

  @override
  _SceneendState createState() => _SceneendState();
}

class _SceneendState extends State<Sceneend> {
  late AudioPlayer
      backgroundAudioPlayer; // Audio player for the background track

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();

    // Initialize the audio players

    backgroundAudioPlayer = AudioPlayer();

    // Play the background audio track and set it to loop continuously
    playBackgroundAudio('background_audio/scene_end.mp3');
    backgroundAudioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  // Function to play the background audio track
  Future<void> playBackgroundAudio(String backgroundAudioPath) async {
    await backgroundAudioPlayer.play(
      AssetSource(backgroundAudioPath),
    );
  }

  // Function to stop the background audio track
  Future<void> stopBackgroundAudio() async {
    await backgroundAudioPlayer.stop();
  }

  @override
  void dispose() {
    // Dispose of the audioPlayer when the widget is disposed

    backgroundAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/hmong_ntsuab/scene_end.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Positioned(
            bottom: screenHeight * 0.07,
            left: screenHeight * 0.725,
            child: GestureDetector(
              onTap: () {
                stopBackgroundAudio();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: Container(
                width: screenHeight * 0.5, // Adjust width as needed
                height: screenHeight * 0.2, // Adjust height as needed
                color: Colors.transparent, // Make the container transparent
              ),
            ),
          ),
        ],
      ),
    );
  }
}
