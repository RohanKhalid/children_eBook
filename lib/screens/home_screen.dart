import 'package:ebook/widgets/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for SystemChrome

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Force landscape orientation
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
            bottom: screenHeight * 0.04,
            left: screenHeight * 0.79,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CustomPopup(); // Show the custom popup
                  },
                );
              },
              child: Container(
                width: screenHeight * 0.6, // Adjust width as needed
                height: screenHeight * 0.2, // Adjust height as needed
                color: Colors.white, // Make the container transparent
              ),
            ),
          ),
        ],
      ),
    );
  }
}
