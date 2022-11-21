import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPageContent extends StatelessWidget {
  const CalendarPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 254, 254),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ),
        
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35))),
        backgroundColor: const Color.fromARGB(255, 86, 133, 94),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text('Weather'),
          const SizedBox(
            height: 50,
          ),
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: DateTime.now(),
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarFormat: CalendarFormat.month,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
        ],
      ),
    );
  }
}
