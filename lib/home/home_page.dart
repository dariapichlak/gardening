import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gardening/home/pages/calendar_page_content/calendar_page_content.dart';
import 'package:gardening/home/pages/notes_page_content/notes_page_content.dart';
import 'package:gardening/home/pages/plants_page_content/plants_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var index = 1;
  final items = const <Widget>[
    Icon(Icons.calendar_month, size: 30),
    Icon(Icons.note, size: 30),
    Icon(Icons.list_outlined, size: 30),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 86, 133, 94),
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
            color: const Color.fromARGB(255, 86, 133, 94),
            backgroundColor: const Color.fromARGB(255, 254, 254, 254),
            buttonBackgroundColor: const Color.fromARGB(255, 86, 133, 94),
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
