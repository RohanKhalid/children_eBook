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
  late AudioPlayer
      backgroundAudioPlayer; // Audio player for the background track

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();

    // Initialize the audio players

    backgroundAudioPlayer = AudioPlayer();

    // Play the background audio track and set it to loop continuously
    playBackgroundAudio('background_audio/scene_intro.mp3');
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

    backgroundAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    // Get the device's screen size
    double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/scene_title 1.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: screenHeight * 0.06,
            left: screenHeight * 0.725,
            child: GestureDetector(
              onTap: () {
                stopBackgroundAudio();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CustomPopup(); // Show the custom popup
                  },
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
