import 'package:flutter/material.dart';
import 'package:map_test/src/features/location/presentation/pages/location_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LocationListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

