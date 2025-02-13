import 'package:flutter/material.dart';
import 'pages/text_sizing_aligned_page.dart';
import 'pages/container_sizing_aligned_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter PDF Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/text-sizing-aligned',
      routes: {
        '/text-sizing-aligned': (context) => TextSizingAlignedPage(),
        '/container-sizing-aligned': (context) => ContainerSizingAlignedPage(),
      },
    );
  }
}
