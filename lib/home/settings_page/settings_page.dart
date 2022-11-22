import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 86, 133, 94),
      ),
      body: const Center(child: Text('Settings Page')),
      backgroundColor: const Color.fromARGB(255, 86, 133, 94),
    );
  }
}
