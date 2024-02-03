import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) =>Scaffold(
    appBar: AppBar(
      title: const Text("Push Notification"),
    ),
    body: const Center(child: Text('Home Page'),),
  );
}