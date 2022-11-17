import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gardening/home/calendar_page/calendar_page_content.dart';
import 'package:gardening/home/notes_page/notes_page_content.dart';
import 'package:gardening/home/plants_page_content/plants_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var index = 1;
  final items = const <Widget>[
    Icon(Icons.calendar_month, size: 30),
    Icon(Icons.note_add, size: 30),
    Icon(Icons.note, size: 30),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(builder: (context) {
        if (index == 0) {
          return const Center(
            child: CalendarPageContent(),
          );
        }
        if (index == 2) {
          return const Center(
            child: NotesPageContent(),
          );
        }
        return const PlantsPageContent();
      }),
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
            color: Colors.black,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: Colors.black,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 350),
            height: 70,
            index: index,
            onTap: (index) {
              setState(() {
                this.index = index;
              });
            },
            items: items),
      ),
    );
  }
}
