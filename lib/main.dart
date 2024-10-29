import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pmu_labs/presentation/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Безымянная соцсеть',
      home: MyHomePage(title: 'Бакальская Елена'),
    );
  }
}
