import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          Container(
            width: 30,
            height: 30,
            color: Colors.red,
          ),
          Container(
            width: 30,
            height: 30,
            color: Colors.green,
          ),
          Container(
            width: 30,
            height: 30,
            color: Colors.blue,
          ),
          Container(
            width: 30,
            height: 30,
            color: Colors.yellow,
          ),
          Container(
            width: 30,
            height: 30,
            color: Colors.pink,
          ),
          Container(
            width: 30,
            height: 30,
            color: Colors.purple,
          ),
          Container(
            width: 30,
            height: 30,
            color: Colors.red,
          ),
          Container(
            width: 30,
            height: 30,
            color: Colors.green,
          ),
          Container(
            width: 30,
            height: 30,
            color: Colors.blue,
          ),
          Container(
            width: 30,
            height: 30,
            color: Colors.yellow,
          ),
          Container(
            width: 30,
            height: 30,
            color: Colors.pink,
          ),
          Container(
            width: 30,
            height: 30,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}
