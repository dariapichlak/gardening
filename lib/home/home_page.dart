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
  var currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const Center(
            child: CalendarPageContent(),
          );
        }
        if (currentIndex == 2) {
          return const Center(
            child: NotesPageContent(),
          );
        }
        return const PlantsPageContent();
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_add),
            label: 'Plants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: 'Notes',
          ),
        ],
      ),
    );
  }
}
