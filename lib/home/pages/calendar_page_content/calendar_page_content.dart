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
      backgroundColor: const Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: IconButton(
            icon: const Icon(
              Icons.person,
              color: Color.fromARGB(255, 172, 172, 172),
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const Settings()));
            },
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 242, 242, 242),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Column(
          children: [
            Container(
              width: 240,
              height: 240,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(140)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Gdynia'),
                  Text('12 oC'),
                  Text('sunny'),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(blurRadius: 15, offset: Offset(0, 10)),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SfCalendar(
                    view: CalendarView.month,
                    initialSelectedDate: DateTime.now(),
                    cellBorderColor: Colors.transparent,
                    showNavigationArrow: true,
                    headerHeight: 70,
                    headerStyle: const CalendarHeaderStyle(
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Antic',
                          letterSpacing: 5,
                          color: Color.fromARGB(255, 86, 133, 94),
                          fontWeight: FontWeight.w400),
                    ),
                    todayHighlightColor: const Color.fromARGB(255, 86, 133, 94),
                    selectionDecoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: const Color.fromARGB(255, 86, 133, 94),
                        width: 1.5,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
