import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  static const route='/notification-screen';
  @override
  Widget build(BuildContext context) {
    final message=ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Notification'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('this is title'),
            SizedBox(height: 10),
            Text('this is body'),
          ],
        ),
      ),
    );
  }
}