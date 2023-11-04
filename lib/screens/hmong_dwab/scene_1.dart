// ignore_for_file: library_private_types_in_public_api

import 'package:ebook/animations/back_page_animation.dart';
import 'package:ebook/animations/forward_page_animation.dart';
import 'package:ebook/screens/hmong_dwab/scene_2.dart';
import 'package:ebook/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart'; // Import the audioplayers package

class SceneD1 extends StatefulWidget {
  const SceneD1({Key? key}) : super(key: key);

  @override
  _SceneD1State createState() => _SceneD1State();
}

class _SceneD1State extends State<SceneD1> {
  AudioPlayer audioPlayer = AudioPlayer(); // Create an instance of AudioPlayer
  AudioPlayer backgroundAudioPlayer =
      AudioPlayer(); // Audio player for the background track

  String text = 'he he he he he he he he he';
  bool isPlaying = false;
  Duration audioPosition = Duration.zero;
  bool isGifPlaying = true;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();

    // Initialize the audio players

    // Play the current audio track
    playAudio('hmong_dwab_audio/scene_1.m4a');

    playBackgroundAudio('background_audio/scene_1.mp3');
    backgroundAudioPlayer.setReleaseMode(ReleaseMode.loop);
    audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        audioPosition = position;
      });
    });
  }

  // Function to play the current audio track
  Future<void> playAudio(String audioPath) async {
    if (isPlaying) {
      audioPlayer.pause(); // Pause the audio
      setState(() {
        isPlaying = false;
      });
    } else {
      audioPlayer.seek(audioPosition);
      await audioPlayer.resume(); // Resume the audio
      await audioPlayer.play(
        AssetSource(audioPath),
      );
      setState(() {
        isPlaying = true;
      });
    }
  }

  // Function to play the background audio track
  Future<void> playBackgroundAudio(String backgroundAudioPath) async {
    if (isPlaying) {
      stopBackgroundAudio();
      setState(() {
        isPlaying = false;
      });
    } else {
      await backgroundAudioPlayer.play(
        AssetSource(backgroundAudioPath),
      );
      setState(() {
        isPlaying = true;
      });
    }
  }

  // Function to stop the current audio track
  stopAudio() {
    audioPlayer.stop();
  }

  // Function to stop the background audio track
  stopBackgroundAudio() {
    backgroundAudioPlayer.stop();
  }

  toggleGif() {
    setState(() {
      isGifPlaying = !isGifPlaying;
    });
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              color: Colors.white,
            ),
            height: 50,
            width: screenWidth * 0.8,
            child: Text(
              text,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          if (isPlaying) {
            stopAudio();
            stopBackgroundAudio();
            toggleGif();
          } else {
            playAudio('hmong_dwab_audio/scene_1.m4a');
            playBackgroundAudio('background_audio/scene_1.mp3');
            toggleGif();
          }
          setState(() {
            isPlaying = !isPlaying;
          });
        },
        child: Stack(
          children: [
            // Background Image
            Image.asset(
              'assets/hmong_dwab/scene1.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: screenHeight * 0.0,
              left: screenHeight * 0.6,
              child: isGifPlaying
                  ? Image.asset(
                      'assets/hmong_dwab_gif/corn_girl.gif',
                      height: 300,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/hmong_dwab_gif/corn_girl_icon.png',
                      height: 320,
                      width: 130,
                    ),
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
                      page: const SceneD2(),
                    ),
                  );
                },
                child: Container(
                  width: screenHeight * 0.2,
                  height: screenHeight * 0.2,
                  color: Colors.red,
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
                      page: const HomeScreen(),
                    ),
                  );
                },
                child: Container(
                  width: screenHeight * 0.2,
                  height: screenHeight * 0.2,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
