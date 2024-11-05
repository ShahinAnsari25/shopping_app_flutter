import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  final Color customColor;

  const ProductCard(
      {super.key,
      required this.title,
      required this.price,
      required this.imageUrl,
      required this.customColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Card(
        color: customColor,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                price,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Center(
                child: Image(
                  height: 180,
                  image: AssetImage(imageUrl),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
