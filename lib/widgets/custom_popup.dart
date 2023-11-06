// ignore_for_file: library_private_types_in_public_api

import 'package:ebook/animations/forward_page_animation.dart';
import 'package:ebook/screens/hmong_dwab/scene_1.dart';

import 'package:ebook/screens/hmong_ntsuab/scene_1.dart';
import 'package:flutter/material.dart';

class CustomPopup extends StatefulWidget {
  const CustomPopup({Key? key}) : super(key: key);

  @override
  _CustomPopupState createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  double opacity = 0.0; // Initial opacity is set to 0 (fully transparent)

  @override
  void initState() {
    super.initState();
    // Start the fade-in animation when the widget is initialized
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        opacity = 1.0; // Set opacity to 1 (fully opaque)
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: AnimatedOpacity(
          duration:
              const Duration(milliseconds: 1000), // Duration of the animation
          opacity: opacity,
          child: Stack(
            children: [
              Container(
                // Your existing content goes here
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                  image: const DecorationImage(
                    image: AssetImage('assets/alert_box.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                width: screenHeight * 0.8,
                height: screenHeight * 0.5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: screenHeight * 0.08,
                              top: screenHeight * 0.03),
                          child: Container(
                            height: 35,
                            width: 155,
                            decoration: BoxDecoration(
                              color: const Color(
                                  0xFFED82FE), // Use the color ED82FE
                              borderRadius: BorderRadius.circular(
                                  6), // Define the border radius
                            ),
                            child: const Center(child: Text('Select Language')),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                            // Icon color (white)
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to the second screen with a fade transition
                            Navigator.of(context).push(
                              SlideRightPageRoute(
                                page: const Scene1(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                                0xFFFF5C00), // Background color FF5C00
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            minimumSize:
                                const Size(159, 41), // Width and height
                          ),
                          child: const Text(
                            'Hmong Ntsuab',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to Scene1
                            Navigator.of(context).push(
                              SlideRightPageRoute(
                                page: const SceneD1(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                                0xFF1DCE00), // Background color 1DCE00
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            minimumSize:
                                const Size(159, 41), // Width and height
                          ),
                          child: const Text(
                            'Hmong Dawb',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
