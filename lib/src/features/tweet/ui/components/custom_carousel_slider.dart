import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarouselSlider extends StatelessWidget {
  final List<String> imageNetworkUrl;
  final double imageHeight;
  const CustomCarouselSlider(
      {super.key, required this.imageNetworkUrl, required this.imageHeight});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: imageNetworkUrl.length,
      itemBuilder: (BuildContext context, int index, _) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            imageNetworkUrl[index],
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return LinearProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                );
              }
            },
            fit: BoxFit.cover,
          ),
        );
      },
      options: CarouselOptions(
        height: imageHeight,
        viewportFraction:
            1, // Defina o tamanho das imagens em relação ao carrossel
      ),
    );
  }
}
