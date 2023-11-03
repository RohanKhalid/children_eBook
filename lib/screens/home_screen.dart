import 'package:audioplayers/audioplayers.dart';
import 'package:ebook/widgets/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for SystemChrome

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPlaying = false;
  bool isGifPlaying = true;

  AudioPlayer backgroundAudioPlayer = AudioPlayer();

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
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
      isGifPlaying = !isGifPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    // Get the device's screen size
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenWidth = MediaQuery.of(context).size.width;

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
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),

            Positioned(
              bottom: screenHeight * 0.06,
              left: screenHeight * 0.725,
              child: GestureDetector(
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
                child: Container(
                  width: screenHeight * 0.5, // Adjust width as needed
                  height: screenHeight * 0.2, // Adjust height as needed
                  color: Colors.transparent, // Make the container transparent
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Image.asset(
                    'assets/hmong_dwab_gif/hen.gif',
                    width: 80,
                    height: 80,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: screenHeight * 0.17,
              right: screenHeight * 0.300,
              child: isGifPlaying
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(3.141),
                      child: Image.asset(
                        'assets/hmong_dwab_gif/bird.gif',
                        width: 200,
                        height: 100,
                      ),
                    )
                  : Image.asset(
                      'assets/hmong_dwab_gif/bird_icon.png',
                      width: 200,
                      height: 100,
                    ),
            ),
            Positioned(
              bottom: screenHeight * 0.06,
              right: screenHeight * 0.200,
              child: Image.asset(
                'assets/hmong_dwab_gif/girl.gif',
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
