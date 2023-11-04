// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

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
   AudioPlayer backgroundAudioPlayer = AudioPlayer(); // Audio player for the background track

   TextEditingController textController = TextEditingController();
   bool isPlaying = false;
   Duration audioPosition = Duration.zero;
   int audioDuration = 10; // Set the audio duration in seconds
   // Store the audio position
   int totalTextLength = 0;
   double typingSpeed = 0;





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


    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        audioDuration = duration.inSeconds; // Get the audio duration
        totalTextLength = 'Peb cov hmoob nyob saum roob ua liaj ua teb noj.'.length;
        typingSpeed = totalTextLength / audioDuration;// Get the audio duration
      });
    });

    audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        audioPosition = position;
        if (audioPosition.inSeconds < audioDuration) {
          int textPosition = (audioPosition.inSeconds * typingSpeed).floor();
          textController.text = 'Peb cov hmoob nyob saum roob ua liaj ua teb noj.'.substring(0, textPosition);
        }
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
      await audioPlayer.play(AssetSource(audioPath),);
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
      await backgroundAudioPlayer.play(AssetSource(backgroundAudioPath),);
      setState(() {
        isPlaying = true;
      });
    }

  }

  // Function to stop the current audio track
  stopAudio()  {
     audioPlayer.stop();
  }

  // Function to stop the background audio track
  stopBackgroundAudio()  {
     backgroundAudioPlayer.stop();
  }

  @override
  void dispose() {
    // Dispose of the audioPlayer when the widget is disposed
    audioPlayer.dispose();
    backgroundAudioPlayer.dispose();
    textController.dispose();
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
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                controller: textController, // Use the text controller to control the text
                readOnly: true,
                style: TextStyle(fontFamily:'TimesNewRoman',fontSize: 22,fontWeight: FontWeight.w400, color: Colors.black),
              ),
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: (){
          if (isPlaying) {
            stopAudio();
            stopBackgroundAudio();
          } else {
            playAudio('hmong_dwab_audio/scene_1.m4a');
            playBackgroundAudio('background_audio/scene_1.mp3');
          }
          setState(() {
            isPlaying = !isPlaying;
          });
        },
        child: Stack(
          children: [
            // Background Image
            Image.asset(
              'assets/hmong_dwab/scene_1.png',
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
                      page: const SceneD2(),
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
                      page: const HomeScreen(),
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
      ),
    );
  }
}
