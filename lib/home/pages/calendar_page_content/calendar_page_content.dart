import 'package:flutter/material.dart';
import 'package:gardening/home/settings/settings.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPageContent extends StatefulWidget {
  const CalendarPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<CalendarPageContent> createState() => _CalendarPageContentState();
}

class _CalendarPageContentState extends State<CalendarPageContent> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 254, 254),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const Settings()));
            },
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
            height: 210,
          ),
          SfCalendar(
            view: CalendarView.month,
            initialSelectedDate: DateTime.now(),
            cellBorderColor: Colors.transparent,
            showNavigationArrow: true,
            headerHeight: 70,
            headerStyle: const CalendarHeaderStyle(
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 5,
                  color: Colors.black,
                  fontWeight: FontWeight.w300),
            ),
            todayHighlightColor: const Color.fromARGB(255, 255, 196, 2),
            selectionDecoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: const Color.fromARGB(255, 255, 196, 2),
                width: 1.5,
              ),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
