// import 'package:ebook/animations/forward_page_animation.dart';
// import 'package:ebook/screens/hmong_ntsuab/scene_2.dart';
// import 'package:ebook/screens/home_screen.dart';
// import 'package:ebook/widgets/audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class Scene1 extends StatelessWidget {
//   const Scene1({super.key});

// ignore_for_file: library_private_types_in_public_api

//   @override
//   Widget build(BuildContext context) {
//     // Force landscape orientation
//     SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
//     double screenHeight = MediaQuery.of(context).size.height;
//     // double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background Image
//           Image.asset(
//             'assets/hmong_ntsuab/scene_1.png',
//             width: double.infinity,
//             height: double.infinity,
//             fit: BoxFit.fill,
//           ),
//           Positioned(
//             top: screenHeight * 0.1,
//             right: screenHeight * 0.7,
//             child: Container(
//               color: Colors.transparent,
//               height: 200,
//               width: 200,
//               child: const AudioPlayerScreen(
//                 audioAssetPath: 'hmong_ntsuab_audio/scene_1.m4a',
//               ),
//             ),
//           ),
//           Positioned(
//             top: screenHeight * 0.01,
//             right: screenHeight * 0.01,
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const HomeScreen(),
//                   ),
//                 );
//               },
//               child: Container(
//                 width: screenHeight * 0.2, // Adjust width as needed
//                 height: screenHeight * 0.2, // Adjust height as needed
//                 color: Colors.transparent, // Make the container transparent
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: screenHeight * 0.4,
//             right: screenHeight * 0.01,
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.of(context).push(
//                   SlideRightPageRoute(
//                     page: const Scene2(),
//                   ),
//                 );
//               },
//               child: Container(
//                 width: screenHeight * 0.2, // Adjust width as needed
//                 height: screenHeight * 0.2, // Adjust height as needed
//                 color: Colors.transparent, // Make the container transparent
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: screenHeight * 0.4,
//             left: screenHeight * 0.01,
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const HomeScreen(),
//                   ),
//                 );
//               },
//               child: Container(
//                 width: screenHeight * 0.2, // Adjust width as needed
//                 height: screenHeight * 0.2, // Adjust height as needed
//                 color: Colors.transparent, // Make the container transparent
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:ebook/animations/forward_page_animation.dart';
import 'package:ebook/screens/hmong_ntsuab/scene_2.dart';
import 'package:ebook/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart'; // Import the audioplayers package

class Scene1 extends StatefulWidget {
  const Scene1({Key? key}) : super(key: key);

  @override
  _Scene1State createState() => _Scene1State();
}

class _Scene1State extends State<Scene1> {
  late AudioPlayer audioPlayer; // Create an instance of AudioPlayer

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
    // Initialize the audioPlayer
    audioPlayer = AudioPlayer();

    // Play the audio file when the widget is initialized
    playAudio();
  }

  // Function to play the audio
  Future<void> playAudio() async {
    await audioPlayer.play(
      AssetSource('hmong_ntsuab_audio/scene_1.m4a'),
    );
  }

  // Function to stop audio
  Future<void> stopAudio() async {
    await audioPlayer.stop();
  }

  @override
  void dispose() {
    // Dispose of the audioPlayer when the widget is disposed
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/hmong_ntsuab/scene_1.png',
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
                stopAudio(); // Stop audio before navigating to the next screen
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
                stopAudio(); // Stop audio before navigating to the next screen
                Navigator.of(context).push(
                  SlideRightPageRoute(
                    page: const Scene2(),
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
                stopAudio(); // Stop audio before navigating to the next screen
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
        ],
      ),
    );
  }
}
