import 'package:flutter/material.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          color: Colors.green,
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(child: Text('Cześć')),
            ],
          ),
        ),
      ),
    );
  }
}
