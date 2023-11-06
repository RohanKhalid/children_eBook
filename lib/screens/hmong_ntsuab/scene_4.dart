// ignore_for_file: library_private_types_in_public_api

import 'package:ebook/animations/back_page_animation.dart';
import 'package:ebook/animations/forward_page_animation.dart';
import 'package:ebook/screens/hmong_ntsuab/scene_3.dart';
import 'package:ebook/screens/hmong_ntsuab/scene_5.dart';
import 'package:ebook/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:gif_view/gif_view.dart';
import 'package:sizer/sizer.dart'; // Import the audioplayers package

class Scene4 extends StatefulWidget {
  const Scene4({Key? key}) : super(key: key);

  @override
  _Scene4State createState() => _Scene4State();
}

class _Scene4State extends State<Scene4> {
  final GifController _gifControllerBird = GifController();
  final GifController _gifControllerScene3_1 = GifController();
  final GifController _gifControllerScene3_2 = GifController();
  final GifController _gifControllerScene3_3 = GifController();
  final GifController _gifControllerStones = GifController();
  final GifController _gifControllerBird2 = GifController();
  final GifController _gifControllerStones2 = GifController();
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
    'miv',
    'nyuag',
    'ntxhais',
    'Moob',
    'nyam',
    'dla',
    'yas',
    'ua',
    'si',
    'hab',
    'pov',
    'pob',
    'zeb.',
  ];
  int currentWordIndex = 0;
  @override
  void initState() {
    super.initState();

    // Play the current audio track
    playAudio('hmong_ntsuab_audio/scene_4.m4a');

    // Play the background audio track and set it to loop continuously
    playBackgroundAudio('background_audio/scene_4.mp3');
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
        _gifControllerStones.stop();
        _gifControllerScene3_1.stop();
        _gifControllerScene3_2.stop();
        _gifControllerScene3_3.stop();
        _gifControllerStones2.stop();
        _gifControllerBird2.stop();
        _gifControllerBird.stop();
      } else {
        _gifControllerStones.play();
        _gifControllerScene3_1.play();
        _gifControllerScene3_2.play();
        _gifControllerScene3_3.play();
        _gifControllerStones2.play();
        _gifControllerBird2.play();
        _gifControllerBird.play();
      }
      isGifPlaying = !isGifPlaying;
    });
  }

  @override
  void dispose() {
    // Dispose of the audioPlayer when the widget is disposed
    audioPlayer.dispose();
    backgroundAudioPlayer.dispose();
    _gifControllerStones.dispose();
    _gifControllerScene3_1.dispose();
    _gifControllerScene3_2.dispose();
    _gifControllerScene3_3.dispose();
    _gifControllerStones2.dispose();
    _gifControllerBird2.dispose();
    _gifControllerBird.dispose();
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
                for (int i = 0; i < words.length; i++)
                  Text(
                    '${words[i]} ',
                    maxLines: 2,
                    style: TextStyle(
                        color: i == currentWordIndex ? textColor : Colors.black,
                        fontFamily: 'TimesNewRoman',
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
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
            'assets/hmong_dwab/scene4.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Positioned(
            top: 32.h,
            right: 20.w,
            child: SizedBox(
              child: GifView.asset(
                'assets/hmong_dwab_gif/bird2.gif', // Replace with your .gif file path
                controller: _gifControllerBird2,
                height: 5.h,
                repeat:
                    ImageRepeat.noRepeat, // Set whether the GIF should repeat
              ),
            ),
          ),

          Positioned(
              top: 22.h,
              right: 46.h,
              child: SizedBox(
                child: GifView.asset(
                  'assets/hmong_dwab_gif/scene_3.1.gif', // Replace with your .gif file path
                  height: 35.h,
                  controller: _gifControllerScene3_1,
                  repeat:
                      ImageRepeat.noRepeat, // Set whether the GIF should repeat
                ),
              )),
          Positioned(
              top: 14.h,
              right: 35.w,
              child: SizedBox(
                child: GifView.asset(
                  'assets/hmong_dwab_gif/scene_3.2.gif', // Replace with your .gif file path
                  height: 35.h,
                  controller: _gifControllerScene3_2,
                  repeat:
                      ImageRepeat.noRepeat, // Set whether the GIF should repeat
                ),
              )),

          Positioned(
              top: 10.h,
              left: 50.w,
              child: SizedBox(
                child: GifView.asset(
                  'assets/hmong_dwab_gif/scene_3.3.gif', // Replace with your .gif file path
                  height: 50.h,
                  controller: _gifControllerScene3_3,
                  repeat:
                      ImageRepeat.noRepeat, // Set whether the GIF should repeat
                ),
              )),
          Positioned(
              top: 35.h,
              left: 20.h,
              child: SizedBox(
                child: GifView.asset(
                  'assets/hmong_dwab_gif/stones2.gif', // Replace with your .gif file path
                  height: 20.h,
                  controller: _gifControllerStones2,
                  repeat:
                      ImageRepeat.noRepeat, // Set whether the GIF should repeat
                ),
              )),
          Positioned(
              top: 44.h,
              left: 29.h,
              child: SizedBox(
                child: GifView.asset(
                  'assets/hmong_dwab_gif/stones.gif', // Replace with your .gif file path
                  height: 8.h,
                  controller: _gifControllerStones,
                  repeat:
                      ImageRepeat.noRepeat, // Set whether the GIF should repeat
                ),
              )),
          Positioned(
              top: 45.h,
              left: 25.h,
              child: SizedBox(
                child: GifView.asset(
                  'assets/hmong_dwab_gif/stones.gif', // Replace with your .gif file path
                  height: 8.h,
                  controller: _gifControllerStones,
                  repeat:
                      ImageRepeat.noRepeat, // Set whether the GIF should repeat
                ),
              )),
          Positioned(
              top: 37.h,
              left: 33.h,
              child: SizedBox(
                child: GifView.asset(
                  'assets/hmong_dwab_gif/bird.gif', // Replace with your .gif file path
                  height: 10.h,
                  controller: _gifControllerBird,
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
                    page: const Scene5(),
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
                    page: const Scene3(),
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
            padding: EdgeInsets.only(top: 80.0, left: screenWidth * 0.5),
            child: GestureDetector(
              onTap: () {
                if (isPlaying) {
                  stopAudio();
                  stopBackgroundAudio();
                } else {
                  playAudio('hmong_dwab_audio/scene_1.m4a');
                  playBackgroundAudio('background_audio/scene_1.mp3');
                }
                toggleGif();
                setState(() {
                  isPlaying = !isPlaying;
                });
              },
              child: isGifPlaying
                  ? Image.asset('assets/hmong_dwab/pause.png')
                  : Image.asset('assets/hmong_dwab/play.png'),
            ),
          ),
        ],
      ),
    );
  }
}
