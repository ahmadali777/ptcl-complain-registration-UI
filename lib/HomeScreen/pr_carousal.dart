import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PrCarousal extends StatefulWidget {
const PrCarousal({super.key});

  @override
   State<PrCarousal> createState() => _PrCarousalState();
}

class _PrCarousalState extends State<PrCarousal> {
 @override
  Widget build(BuildContext context) {
    // List of images
    final List<String> imagePaths = [
      'assets/carousal/landline_plan.jpg',
      'assets/carousal/ptcl_packages.jpg',
      'assets/carousal/tenMBoffer.jpg',
    ];

    return SizedBox(
      height: 200,
      child: CarouselSlider(
        items: imagePaths.map((imagePath) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          );
        }).toList(),
        options: CarouselOptions(
          height: 300, // Set the height of the carousel
          autoPlay: true, // Automatically scrolls through images
          enlargeCenterPage: true, // Zoom effect on the active image
          aspectRatio: 16 / 9, // Aspect ratio of the slider
          viewportFraction: 0.8, // Fraction of the screen the item occupies
        ),
      ),
    );
  }
}