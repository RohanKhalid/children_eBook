import 'package:ebook/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Sceneend extends StatelessWidget {
  const Sceneend({super.key});

  @override
  Widget build(BuildContext context) {
    // Force landscape orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/hmong_ntsuab/scene_end.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Positioned(
            bottom: screenHeight * 0.07,
            left: screenHeight * 0.725,
            child: GestureDetector(
              onTap: () {
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
