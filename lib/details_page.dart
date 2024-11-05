import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/cart_provider.dart';

class DetailsPage extends StatefulWidget {
  final String title;
  final String imageUrl;
  final List sizes;
  final String price;
  const DetailsPage({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.sizes,
    required this.price,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late String selectedSize;
  @override
  void initState() {
    super.initState();
    selectedSize = widget.sizes[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Details",
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          SizedBox(
            height: 250,
            child: Image.asset(widget.imageUrl),
          ),
          const Spacer(
            flex: 2,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Color.fromRGBO(245, 247, 249, 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.price,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.sizes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = widget.sizes[index];
                            });
                          },
                          child: Chip(
                            label: Text(
                              widget.sizes[index],
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            elevation: 20,
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            backgroundColor: selectedSize == widget.sizes[index]
                                ? const Color.fromRGBO(254, 206, 1, 1)
                                : const Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .addProduct({
                        'title': widget.title,
                        'price': widget.price,
                        'imageUrl': widget.imageUrl,
                        'size': selectedSize
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Item added to cart.")));
                    },
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Add To Cart",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
