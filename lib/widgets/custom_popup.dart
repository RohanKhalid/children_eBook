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
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            top: screenHeight * 0.15,
            left: screenWidth * 0.2,
            child: Container(
              width: screenWidth * 0.6,
              height: screenHeight * 0.8,
              child: Center(
                child: AnimatedOpacity(
                  duration: const Duration(
                      milliseconds: 1000), // Duration of the animation
                  opacity: opacity,
                  child: Container(
                    // Your existing content goes here
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36),
                      image: const DecorationImage(
                        image: AssetImage('assets/alert_box.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, right: 15),
                              child: SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      padding: EdgeInsets.zero,
                                      shape: const RoundedRectangleBorder(),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 17,
                                    ),
                                  )),
                            )
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
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
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
                                    const Size(170, 41), // Width and height
                              ),
                              child: const Text(
                                'Hmong Dawb',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.25,
            left: screenWidth / 2 * 0.8,
            child: Container(
              height: 40,
              width: 155,
              decoration: BoxDecoration(
                color: const Color(0xFFED82FE), // Use the color ED82FE
                borderRadius:
                    BorderRadius.circular(6), // Define the border radius
              ),
              child: const Center(
                child: Text(
                  'Select Language',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
