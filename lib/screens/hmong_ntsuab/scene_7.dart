// ignore_for_file: library_private_types_in_public_api

import 'package:ebook/animations/back_page_animation.dart';
import 'package:ebook/animations/forward_page_animation.dart';
import 'package:ebook/screens/hmong_dwab/scene_end.dart';
import 'package:ebook/screens/hmong_ntsuab/scene_6.dart';

import 'package:ebook/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:gif_view/gif_view.dart';
import 'package:sizer/sizer.dart'; // Import the audioplayers package

class Scene7 extends StatefulWidget {
  const Scene7({Key? key}) : super(key: key);

  @override
  _Scene7State createState() => _Scene7State();
}

class _Scene7State extends State<Scene7> with WidgetsBindingObserver {
  final GifController _gifControllerScene7_1 = GifController();

  final GifController _gifControllerBird = GifController();
  static const MethodChannel _channel = MethodChannel('Scene_7');
  static AudioPlayer audioPlayer =
      AudioPlayer(); // Create an instance of AudioPlayer
  static AudioPlayer backgroundAudioPlayer =
      AudioPlayer(); // Audio player for the background track
  bool isPlaying = false;
  Duration audioPosition = Duration.zero;
  int audioDuration = 10; // Set the audio duration in seconds
  Color textColor = Colors.black; // Initial text color
  Color targetColor = Colors.green; // Target text color
  bool isGifPlaying = true;
  List<String> words = [
    'Quas',
    'puj',
    'Moob',
    'tuav',
    'cog',
    'haj',
    'tau',
    'ntsab',
    'lug',
    'ua',
    'mov',
    'noj.',
  ];
  int currentWordIndex = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Play the current audio track
    playAudio('hmong_ntsuab_audio/scene_7.m4a');

    // Play the background audio track and set it to loop continuously
    playBackgroundAudio('background_audio/scene_7.mp3');
    backgroundAudioPlayer.setReleaseMode(ReleaseMode.loop);

    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        audioDuration = duration.inMilliseconds; // Get the audio duration
      });
    });

    audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        audioPosition = position;
        updateTextColor();
      });
    });
  }

  // Call this method to pause or stop the music when the screen is locked.
  Future<void> pauseMusicOnLockScreen() async {
    try {
      await _channel.invokeMethod('pauseMusic');
    } on PlatformException catch (e) {
      print('$e');
      // Handle the error.
    }
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
    await backgroundAudioPlayer.release();
  }

  void updateTextColor() {
    double progress = audioPosition.inMilliseconds / audioDuration;
    int newSegmentIndex = (progress * words.length).floor();
    if (newSegmentIndex < words.length && newSegmentIndex != currentWordIndex) {
      setState(() {
        currentWordIndex = newSegmentIndex;
        textColor = targetColor;
      });
    }
  }

  toggleGif() {
    setState(() {
      if (isGifPlaying) {
        _gifControllerScene7_1.stop();

        _gifControllerBird.stop();
      } else {
        _gifControllerScene7_1.play();

        _gifControllerBird.play();
      }
      isGifPlaying = !isGifPlaying;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      backgroundAudioPlayer.pause();
      audioPlayer.pause();
    } else if (state == AppLifecycleState.resumed) {
      backgroundAudioPlayer.resume();
      audioPlayer.resume();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Dispose of the audioPlayer when the widget is disposed
    audioPlayer.dispose();
    backgroundAudioPlayer.dispose();

    _gifControllerScene7_1.dispose();

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
            'assets/hmong_dwab/scene7.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),

          Positioned(
              top: 17.h,
              left: 25.w,
              child: SizedBox(
                child: GifView.asset(
                  'assets/hmong_dwab_gif/scene-7.gif', // Replace with your .gif file path
                  height: 30.h,
                  controller: _gifControllerScene7_1,
                  repeat:
                      ImageRepeat.noRepeat, // Set whether the GIF should repeat
                ),
              )),

          Positioned(
              top: 26.h,
              right: 11.h,
              child: SizedBox(
                child: GifView.asset(
                  'assets/hmong_dwab_gif/bird.gif', // Replace with your .gif file path
                  height: 8.h,
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
                    page: const SceneendD(),
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
                    page: const Scene6(),
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
                  playAudio('hmong_ntsuab_audio/scene_7.m4a');
                  playBackgroundAudio('background_audio/scene_7.mp3');
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
                        startAudioFromBeginning(
                            'hmong_ntsuab_audio/scene_7.m4a');
                        playBackgroundAudio('background_audio/scene_7.mp3');
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
