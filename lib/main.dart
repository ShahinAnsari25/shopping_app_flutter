import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/cart_provider.dart';
import 'package:shopping_app/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping App',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(254, 206, 1, 1),
            primary: const Color.fromRGBO(254, 206, 1, 1),
          ),
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              titleTextStyle:
                  TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(
              color: Color.fromRGBO(119, 119, 119, 1),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
          ),
          textTheme: const TextTheme(
            titleMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            titleSmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        home: const HomeScreen(),

        // home: DetailsPage(
        //   title: product['title'] as String,
        //   imageUrl: product['imageUrl'] as String,
        //   price: product['price'] as String,
        //   shades: product['shades'] as List,
        // ),
      ),
    );
  }
}
