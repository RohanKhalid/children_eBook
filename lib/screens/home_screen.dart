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

class _HomeScreenState extends State<HomeScreen> {
  bool isPlaying = false;
  bool isGifPlaying = true;

  AudioPlayer backgroundAudioPlayer = AudioPlayer();

  final GifController _gifControllerHen = GifController();
  final GifController _gifControllerBird = GifController();
  final GifController _gifControllerGirl = GifController();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
    playBackgroundAudio('background_audio/scene_intro.mp3');
    // backgroundAudioPlayer.setReleaseMode(ReleaseMode.loop);
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
  void dispose() {
    backgroundAudioPlayer.dispose();
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
                  setState(() {
                    stopBackgroundAudio();
                  });
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CustomPopup(); // Show the custom popup
                    },
                  ).then((_) =>
                      playBackgroundAudio('background_audio/scene_intro.mp3'));
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
