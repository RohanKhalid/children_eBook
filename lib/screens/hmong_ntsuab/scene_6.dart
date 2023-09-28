// ignore_for_file: library_private_types_in_public_api

import 'package:ebook/animations/back_page_animation.dart';
import 'package:ebook/animations/forward_page_animation.dart';
import 'package:ebook/screens/hmong_ntsuab/scene_5.dart';
import 'package:ebook/screens/hmong_ntsuab/scene_7.dart';
import 'package:ebook/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart'; // Import the audioplayers package

class Scene6 extends StatefulWidget {
  const Scene6({Key? key}) : super(key: key);

  @override
  _Scene6State createState() => _Scene6State();
}

class _Scene6State extends State<Scene6> {
  late AudioPlayer audioPlayer; // Create an instance of AudioPlayer

  @override
  void initState() {
    super.initState();
    // Initialize the audioPlayer
    audioPlayer = AudioPlayer();

    // Play the audio file when the widget is initialized
    playAudio();
  }

  // Function to play the audio
  Future<void> playAudio() async {
    await audioPlayer.play(
      AssetSource('hmong_ntsuab_audio/scene_6.m4a'),
    );
  }

  // Function to stop audio
  Future<void> stopAudio() async {
    await audioPlayer.stop();
  }

  @override
  void dispose() {
    // Dispose of the audioPlayer when the widget is disposed
    audioPlayer.dispose();
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
            'assets/hmong_ntsuab/scene_6.png',
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
                Navigator.of(context).push(
                  SlideRightPageRoute(
                    page: const Scene7(),
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
                Navigator.of(context).push(
                  SlideRightPageRouteB(
                    page: const Scene5(),
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
