import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/material_images.dart';

class ImageSlider extends StatefulWidget {
  List<MaterialImage>? images;

  ImageSlider({this.images, Key? key}) : super(key: key);
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: widget.images!.map((i) {
            return Builder(
                builder: (BuildContext context) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          i.image,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width * 0.33,
                        ),
                      ),
                    ));
          }).toList(),
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.33,
            onPageChanged: (int i, carouselPageChangedReason) {
              setState(() {
                index = i;
              });
            },
            initialPage: 0,
            autoPlay: true,
            viewportFraction: 1,
          ),
        ),
      ],
    );
  }
}
