import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  final String title;

  const DemoPage({super.key, required this.title});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust text size based on screen width (responsive)
    double fontSize = screenWidth < 400
        ? 18
        : screenWidth < 800
            ? 24
            : 32;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}