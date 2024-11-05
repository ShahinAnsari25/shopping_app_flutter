import 'package:flutter/material.dart';
import 'package:shopping_app/data.dart';
import 'package:shopping_app/details_page.dart';
import 'package:shopping_app/product_card.dart';

class ItemList extends StatefulWidget {
  const ItemList({super.key});
  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  TextEditingController searchController = TextEditingController();
  String selectedFilter = 'All';
  String searchedString = '';
  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        searchedString =
            searchController.text; // Update state with the current text
      });
    });
  }

  @override
  void dispose() {
    searchController
        .dispose(); // Dispose of the controller when no longer needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(searchedString);
    const List<String> filters = [
      'All',
      'Men',
      'Women',
    ];
    final filteredProducts = searchedString != ''
        ? products
            .where((product) => (product['title'] as String)
                .toLowerCase()
                .contains(searchedString.toLowerCase()))
            .toList()
        : selectedFilter == 'All'
            ? products
            : products
                .where((product) =>
                    product['category'] == selectedFilter.toLowerCase())
                .toList();

    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(228, 226, 226, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "Shoes\nCollection",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filters[index];
                        });
                      },
                      child: Chip(
                        label: Text(
                          filters[index],
                          style: const TextStyle(fontSize: 16),
                        ),
                        backgroundColor: selectedFilter == filters[index]
                            ? const Color.fromRGBO(254, 206, 1, 1)
                            : const Color.fromRGBO(245, 247, 249, 1),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        side: const BorderSide(
                          width: 0,
                          color: Color.fromRGBO(245, 247, 249, 1),
                        ),
                      ),
                    ));
              },
            ),
          ),
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth < 850) {
                return ListView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(
                                title: product['title'] as String,
                                imageUrl: product['imageUrl'] as String,
                                sizes: product['sizes'] as List,
                                price: product['price'] as String),
                          ),
                        );
                      },
                      child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as String,
                        imageUrl: product['imageUrl'] as String,
                        customColor: index.isEven
                            ? const Color.fromRGBO(216, 240, 253, 1)
                            : const Color.fromRGBO(245, 247, 249, 1),
                      ),
                    );
                  },
                );
              } else {
                return GridView.builder(
                    itemCount: filteredProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 1.5),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                  title: product['title'] as String,
                                  imageUrl: product['imageUrl'] as String,
                                  sizes: product['sizes'] as List,
                                  price: product['price'] as String),
                            ),
                          );
                        },
                        child: ProductCard(
                          title: product['title'] as String,
                          price: product['price'] as String,
                          imageUrl: product['imageUrl'] as String,
                          customColor: index.isEven
                              ? const Color.fromRGBO(216, 240, 253, 1)
                              : const Color.fromRGBO(245, 247, 249, 1),
                        ),
                      );
                    });
              }
            }),
            // child: ListView.builder(
            //   itemCount: products.length,
            //   itemBuilder: (context, index) {
            //     final product = products[index];
            //     return GestureDetector(
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => DetailsPage(
            //                 title: product['title'] as String,
            //                 imageUrl: product['imageUrl'] as String,
            //                 : product[''] as List,
            //                 price: product['price'] as String),
            //           ),
            //         );
            //       },
            //       child: ProductCard(
            //         title: product['title'] as String,
            //         price: product['price'] as String,
            //         imageUrl: product['imageUrl'] as String,
            //         customColor: index.isEven
            //             ? const Color.fromRGBO(216, 240, 253, 1)
            //             : const Color.fromRGBO(245, 247, 249, 1),
            //       ),
            //     );
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}
