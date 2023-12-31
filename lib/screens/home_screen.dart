// ignore_for_file: library_private_types_in_public_api

import 'package:audioplayers/audioplayers.dart';
import 'package:ebook/widgets/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gif_view/gif_view.dart';
import 'package:sizer/sizer.dart'; // Import for SystemChrome

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool isPlaying = false;
  bool isGifPlaying = true;

  static AudioPlayer backgroundAudioPlayer = AudioPlayer();

  final GifController _gifControllerHen = GifController();
  final GifController _gifControllerBird = GifController();
  final GifController _gifControllerGirl = GifController();

  static const MethodChannel _channel = MethodChannel('Music');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    playBackgroundAudio('background_audio/scene_intro.mp3');
    backgroundAudioPlayer.setReleaseMode(ReleaseMode.loop);
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

  // Function to play the background audio track
  playBackgroundAudio(String backgroundAudioPath) {
    if (isPlaying) {
      stopBackgroundAudio();
      setState(() {
        isPlaying = false;
      });
    } else {
      backgroundAudioPlayer.play(AssetSource(backgroundAudioPath));
      setState(() {
        isPlaying = true;
      });
    }
  }

  // Function to stop the background audio track
  stopBackgroundAudio() {
    backgroundAudioPlayer.stop();
    
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      backgroundAudioPlayer.pause();
    } else if (state == AppLifecycleState.resumed) {
      backgroundAudioPlayer.resume();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    backgroundAudioPlayer.dispose();
    _gifControllerBird.dispose();
    _gifControllerGirl.dispose();
    _gifControllerHen.dispose();
    super.dispose();
  }

  toggleGif() {
    setState(() {
      if (isGifPlaying) {
        _gifControllerHen.stop();
        _gifControllerBird.stop();
        _gifControllerGirl.stop();
      } else {
        _gifControllerHen.play();
        _gifControllerBird.play();
        _gifControllerGirl.play();
      }
      isGifPlaying = !isGifPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    // Get the device's screen size
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            playBackgroundAudio('background_audio/scene_intro.mp3');
            toggleGif();
          });
        },
        child: Stack(
          children: [
            // Background Image
            Image.asset(
              'assets/home_bg.png',
              width: double.maxFinite,
              height: double.maxFinite,
              fit: BoxFit.cover,
            ),

            Positioned(
              bottom: 11.h,
              left: 10.w,
              child: SizedBox(
                child: GifView.asset(
                  'assets/hmong_dwab_gif/hen.gif',
                  controller: _gifControllerHen,
                  repeat: ImageRepeat.noRepeat,
                  height: 14.h,
                ),
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.08,
              left: screenHeight * 0.715,
              child: InkWell(
                onTap: () {
                  stopBackgroundAudio();
                  backgroundAudioPlayer.release();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CustomPopup(); // Show the custom popup
                    },
                  );
                },
                child: const SizedBox(
                  height: 70,
                  width: 210,
                ),
              ),
            ),
            Positioned(
                bottom: 8.h,
                right: 35.w,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(3.141),
                  child: SizedBox(
                    child: GifView.asset(
                      'assets/hmong_dwab_gif/bird.gif',
                      controller: _gifControllerBird,
                      repeat: ImageRepeat.noRepeat,
                      height: 14.h,
                    ),
                  ),
                )),
            Positioned(
              bottom: 0,
              right: -6.w,
              child: SizedBox(
                child: GifView.asset(
                  'assets/hmong_dwab_gif/girl.gif',
                  controller: _gifControllerGirl,
                  repeat: ImageRepeat.noRepeat,
                  height: 20.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
