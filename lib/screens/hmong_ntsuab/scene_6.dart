// ignore_for_file: library_private_types_in_public_api

import 'package:ebook/animations/back_page_animation.dart';
import 'package:ebook/animations/forward_page_animation.dart';
import 'package:ebook/screens/hmong_ntsuab/scene_5.dart';
import 'package:ebook/screens/hmong_ntsuab/scene_7.dart';
import 'package:ebook/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:gif_view/gif_view.dart';
import 'package:sizer/sizer.dart'; // Import the audioplayers package

class Scene6 extends StatefulWidget {
  const Scene6({Key? key}) : super(key: key);

  @override
  _Scene6State createState() => _Scene6State();
}

class _Scene6State extends State<Scene6> {
  final GifController _gifControllerScene6_1 = GifController();
  final GifController _gifControllerScene6_2 = GifController();

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
    'quas',
    'puj',
    'Moob',
    'laug',
    'moog',
    'dlais',
    'pob',
    'kws',
    'zum',
    'haj',
    'tau',
    'pub',
    'npua.',
  ];
  int currentWordIndex = 0;

  @override
  void initState() {
    super.initState();

    // Play the current audio track
    playAudio('hmong_ntsuab_audio/scene_6.m4a');

    // Play the background audio track and set it to loop continuously
    playBackgroundAudio('background_audio/scene_6.mp3');
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
        _gifControllerScene6_1.stop();
        _gifControllerScene6_2.stop();
      } else {
        _gifControllerScene6_1.play();
        _gifControllerScene6_2.play();
      }
      isGifPlaying = !isGifPlaying;
    });
  }

  @override
  void dispose() {
    // Dispose of the audioPlayer when the widget is disposed
    audioPlayer.dispose();
    backgroundAudioPlayer.dispose();

    _gifControllerScene6_1.dispose();
    _gifControllerScene6_2.dispose();

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
            'assets/hmong_dwab/scene6.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),

          Positioned(
              top: 14.h,
              right: 53.h,
              child: SizedBox(
                child: GifView.asset(
                  'assets/hmong_dwab_gif/scene_6.1.gif', // Replace with your .gif file path
                  height: 35.h,
                  controller: _gifControllerScene6_1,
                  repeat:
                      ImageRepeat.noRepeat, // Set whether the GIF should repeat
                ),
              )),
          Positioned(
              top: 20.h,
              left: 100.w,
              child: SizedBox(
                child: GifView.asset(
                  'assets/hmong_dwab_gif/scene_6.2.gif', // Replace with your .gif file path
                  height: 40.h,
                  controller: _gifControllerScene6_2,
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
                    page: const Scene7(),
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
                    page: const Scene5(),
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
