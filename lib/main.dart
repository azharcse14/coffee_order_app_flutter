import 'package:coffee_order_app_flutter/home.page.dart';
import 'package:flutter/material.dart';

import 'config/colors_constants.dart';
import 'config/services_locator.dart';

void main() {
  initServicesLocator();
  runApp(const CoffeApp());
}

class CoffeApp extends StatelessWidget {
  const CoffeApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Steizy Coffee',
      debugShowCheckedModeBanner: false,
      // showPerformanceOverlay: true,
      theme: ThemeData(colorSchemeSeed: kBrownColor),
      home: const HomePage(),
    );
  }
}
