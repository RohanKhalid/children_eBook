// ignore_for_file: library_private_types_in_public_api

import 'package:ebook/animations/back_page_animation.dart';
import 'package:ebook/animations/forward_page_animation.dart';
import 'package:ebook/screens/hmong_dwab/scene_1.dart';
import 'package:ebook/screens/hmong_dwab/scene_3.dart';
import 'package:ebook/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:gif_view/gif_view.dart';
import 'package:sizer/sizer.dart'; // Import the audioplayers package

class SceneD2 extends StatefulWidget {
  const SceneD2({Key? key}) : super(key: key);

  @override
  _SceneD2State createState() => _SceneD2State();
}

class _SceneD2State extends State<SceneD2> {
  final GifController _gifControllerAxeBoy = GifController();
  final GifController _gifControllerPigGirl = GifController();
  final GifController _gifControllerLogs = GifController();
  final GifController _gifControllerPig = GifController();
  late AudioPlayer audioPlayer =
      AudioPlayer(); // Create an instance of AudioPlayer
  late AudioPlayer backgroundAudioPlayer =
      AudioPlayer(); // Audio player for the background track
  bool isPlaying = false;
  Duration audioPosition = Duration.zero;
  int audioDuration = 10; // Set the audio duration in seconds
  Color textColor = Colors.black; // Initial text color
  Color targetColor = Colors.green; // Target text color
  bool isGifPlaying = true;
  List<String> words = [
    'Cov',
    'tub',
    'hluas',
    'Hmoob',
    'mus',
    'txiav',
    'taws,',
    'cov',
    'ntxhais',
    'hluas',
    'Hmoob',
    'mus',
    'pub',
    'qaib',
    'pub',
    'npua.',
  ];
  int currentWordIndex = 0;

  @override
  void initState() {
    super.initState();
    // Play the current audio track
    playAudio('hmong_dwab_audio/scene_2.m4a');

    // Play the background audio track and set it to loop continuously
    playBackgroundAudio('background_audio/scene_2.mp3');
    backgroundAudioPlayer.setReleaseMode(ReleaseMode.loop);

    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        audioDuration = duration.inSeconds; // Get the audio duration
      });
    });

    audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        audioPosition = position;
        updateTextColor();
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

  // Function to start audio from the beginning
  Future<void> startAudioFromBeginning(String audioPath) async {
    audioPosition = Duration.zero; // Reset audio position
    currentWordIndex = 0; // Reset the text highlight index
    updateTextColor(); // Update text color based on the reset values
    if (isPlaying) {
      audioPlayer.pause(); // Pause the audio
      await audioPlayer
          .seek(const Duration(milliseconds: 0)); // Seek to the start
      await audioPlayer.resume(); // Resume the audio
      setState(() {
        isPlaying = true;
      });
    } else {
      await audioPlayer
          .seek(const Duration(milliseconds: 0)); // Seek to the start
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
      backgroundAudioPlayer.pause();
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
  Future<void> stopAudio() async {
    await audioPlayer.stop();
  }

  // Function to stop the background audio track
  Future<void> stopBackgroundAudio() async {
    await backgroundAudioPlayer.stop();
  }

  void updateTextColor() {
    double progress = audioPosition.inSeconds / audioDuration;

    if (currentWordIndex < words.length &&
        progress >= (currentWordIndex + 1) / words.length) {
      currentWordIndex++;
      textColor = targetColor;
    }
  }

  toggleGif() {
    setState(() {
      if (isGifPlaying) {
        _gifControllerAxeBoy.stop();
        _gifControllerPigGirl.stop();
        _gifControllerLogs.stop();
        _gifControllerPig.stop();
      } else {
        _gifControllerAxeBoy.play();
        _gifControllerPigGirl.play();
        _gifControllerLogs.play();
        _gifControllerPig.play();
      }
      isGifPlaying = !isGifPlaying;
    });
  }

  @override
  void dispose() {
    // Dispose of the audioPlayer when the widget is disposed
    audioPlayer.dispose();
    backgroundAudioPlayer.dispose();
    _gifControllerAxeBoy.dispose();
    _gifControllerLogs.dispose();
    _gifControllerPigGirl.dispose();
    _gifControllerPig.dispose();
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
        automaticallyImplyLeading: false, // Disable the back arrow
        forceMaterialTransparency: true,
        toolbarHeight: 80,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              color: Colors.white,
            ),
            height: 80,
            width: screenWidth * 0.8,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: List.generate(
                      words.length,
                      (i) {
                        final isHighlighted = i <= currentWordIndex;
                        return TextSpan(
                          text: '${words[i]} ',
                          style: TextStyle(
                            color: isHighlighted ? textColor : Colors.black,
                            fontFamily: 'TimesNewRoman',
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/hmong_dwab/scene2.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Positioned(
            top: 21.h,
            left: 60,
            child: SizedBox(
              height: 20.h,
              child: GifView.asset(
                'assets/hmong_dwab_gif/axe_boy.gif', // Replace with your .gif file path
                controller: _gifControllerAxeBoy,
                repeat:
                    ImageRepeat.noRepeat, // Set whether the GIF should repeat
              ),
            ),
          ),

          Positioned(
              top: 25.h,
              left: 50,
              child: SizedBox(
                child: GifView.asset(
                  'assets/hmong_dwab_gif/logs.gif', // Replace with your .gif file path
                  height: 20.h,
                  controller: _gifControllerLogs,
                  repeat:
                      ImageRepeat.noRepeat, // Set whether the GIF should repeat
                ),
              )),
          Positioned(
              top: 20.h,
              right: 14.w,
              child: SizedBox(
                child: GifView.asset(
                  'assets/hmong_dwab_gif/pig_girl.gif', // Replace with your .gif file path
                  height: 35.h,
                  controller: _gifControllerPigGirl,
                  repeat:
                      ImageRepeat.noRepeat, // Set whether the GIF should repeat
                ),
              )),

          Positioned(
              bottom: 5,
              right: 12.w,
              child: SizedBox(
                child: GifView.asset(
                  'assets/hmong_dwab_gif/pig_left.gif', // Replace with your .gif file path
                  controller: _gifControllerPig,
                  height: 15.h,
                  repeat:
                      ImageRepeat.noRepeat, // Set whether the GIF should repeat
                ),
              )),

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
                child: Image.asset('assets/hmong_dwab/homeicon.png'),
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
                child: Image.asset('assets/hmong_dwab/arrow_right.png'),
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
                child: Image.asset('assets/hmong_dwab/arrow_left.png'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100.0, left: screenWidth * 0.5),
            child: GestureDetector(
              onTap: () {
                if (isPlaying) {
                  stopAudio();
                  stopBackgroundAudio();
                } else {
                  playAudio('hmong_dwab_audio/scene_2.m4a');
                  playBackgroundAudio('background_audio/scene_2.mp3');
                }
                toggleGif();
                setState(() {
                  isPlaying = !isPlaying;
                });
              },
              child: isGifPlaying
                  ? Image.asset(
                      'assets/hmong_dwab/pause.png',
                      height: 50,
                      width: 50,
                    )
                  : Image.asset(
                      'assets/hmong_dwab/play.png',
                      height: 50,
                      width: 50,
                    ),
            ),
          ),
          if (!isGifPlaying)
            isPlaying
                ? Container() // An empty container to make the restart button disappear
                : Positioned(
                    top: 100,
                    right: screenWidth * 0.1,
                    child: GestureDetector(
                      onTap: () {
                        // Restart the audio and text from 0 index here
                        startAudioFromBeginning('hmong_dwab_audio/scene_2.m4a');
                        playBackgroundAudio('background_audio/scene_2.mp3');
                        toggleGif(); // Toggle the GIF state
                        setState(() {
                          isPlaying = true;
                        });
                      },
                      child: Image.asset(
                        'assets/hmong_dwab/replay.png',
                        height: 50,
                        width: 50,
                      ),
                      // Replace with your restart button image
                    ),
                  ),
        ],
      ),
    );
  }
}
