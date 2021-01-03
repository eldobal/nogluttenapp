import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nogluttenapp/src/provider/shopsProvider.dart';
import 'package:provider/provider.dart';

class carrouselImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShopsProvider>(
        builder: (context, provider, child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: CarouselSlider(
            options: CarouselOptions(
              enableInfiniteScroll:
              provider.images.length != 1 ? true : false,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlay: provider.images.length != 1 ? true : false,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: provider.images
                .map((item) => Container(
              child: Center(
                  child: AssetThumb(
                    asset: item,
                    width: 800,
                    height: 800,
                  )),
            ))
                .toList(),
          ),
        ));
  }
}
