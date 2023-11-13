// ignore_for_file: library_private_types_in_public_api

import 'package:audioplayers/audioplayers.dart';
import 'package:ebook/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gif_view/gif_view.dart';
import 'package:sizer/sizer.dart';

class SceneendD extends StatefulWidget {
  const SceneendD({Key? key}) : super(key: key);

  @override
  _SceneendDState createState() => _SceneendDState();
}

class _SceneendDState extends State<SceneendD> {
  late AudioPlayer
      backgroundAudioPlayer = AudioPlayer(); // Audio player for the background track
  final GifController _gifControllerSceneEnd_1 = GifController();
  final GifController _gifControllerSceneEnd_2 = GifController();
  final GifController _gifControllerEnd_3 = GifController();
  final GifController _gifControllerEnd_4 = GifController();

  @override
  void initState() {
    
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    

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
    _gifControllerSceneEnd_1.dispose();
    _gifControllerSceneEnd_2.dispose();
    _gifControllerEnd_3.dispose();
    _gifControllerEnd_4.dispose();
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
            'assets/hmong_dwab/scene_end.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Positioned(
              top: 5.h,
              left: 5.w,
              child: SizedBox(
                child: GifView.asset(
                  'assets/hmong_dwab_gif/end_screen_3.gif', // Replace with your .gif file path
                  height: 25.h,
                  controller: _gifControllerSceneEnd_1,
                  repeat:
                      ImageRepeat.noRepeat, // Set whether the GIF should repeat
                ),
              )),
          Positioned(
              top: 15.h,
              left: 68.w,
              child: SizedBox(
                child: GifView.asset(
                  'assets/hmong_dwab_gif/end_screen_2.gif', // Replace with your .gif file path
                  height: 20.h,
                  controller: _gifControllerSceneEnd_2,
                  repeat:
                      ImageRepeat.noRepeat, // Set whether the GIF should repeat
                ),
              )),

          Positioned(
              bottom: 12.h,
              right: 50.w,
              child: SizedBox(
                child: GifView.asset(
                  'assets/hmong_dwab_gif/end_screen_1.gif', // Replace with your .gif file path
                  height: 30.h,
                  controller: _gifControllerEnd_3,
                  repeat:
                      ImageRepeat.noRepeat, // Set whether the GIF should repeat
                ),
              )),
          Positioned(
              top: 5.h,
              right: 0,
              child: SizedBox(
                child: GifView.asset(
                  'assets/hmong_dwab_gif/end_screen.gif', // Replace with your .gif file path
                  height: 25.h,
                  controller: _gifControllerEnd_4,
                  repeat:
                      ImageRepeat.noRepeat, // Set whether the GIF should repeat
                ),
              )),
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
