import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;
//import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {

  final String title;
  CalendarView({ this.title}) ;

  @override
  _CalendarViewState createState() => new _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();

  CalendarController _controller = CalendarController();

  void initState() {
    super.initState();
    //_controller = CalendarController();
  }

  //EventList<Event> _markedDateMap = new EventList<Event>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Calendar"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: TableCalendar(
                  calendarController: _controller,
                  availableCalendarFormats: const {
                    CalendarFormat.week: 'Two Weeks',
                    CalendarFormat.month: 'Week',
                    CalendarFormat.twoWeeks: "Month",
                  },
                ),
                // child: TableCalendar(
                //   initialCalendarFormat: CalendarFormat.month,
                //   calendarStyle: CalendarStyle(
                //       todayColor: Colors.blue,
                //       selectedColor: Theme.of(context).primaryColor,
                //       todayStyle: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: 22.0,
                //           color: Colors.white),
                // ),
                //   headerStyle: HeaderStyle(
                //     centerHeaderTitle: true,
                //     formatButtonDecoration: BoxDecoration(
                //       color: Colors.black,
                //       borderRadius: BorderRadius.circular(22.0),
                //     ),
                //     formatButtonTextStyle: TextStyle(color: Colors.white),
                //     formatButtonShowsNext: true,
                //   ),
                //   startingDayOfWeek: StartingDayOfWeek.monday,
                //   onDaySelected: (date, events,e) {
                //     print(date.toUtc());
                //   },
                //   builders: CalendarBuilders(
                //     selectedDayBuilder: (context, date, events) => Container(
                //         margin: const EdgeInsets.all(5.0),
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //             color: Theme.of(context).primaryColor,
                //             borderRadius: BorderRadius.circular(8.0)),
                //         child: Text(
                //           date.day.toString(),
                //           style: TextStyle(color: Colors.white),
                //         )),
                //     todayDayBuilder: (context, date, events) => Container(
                //         margin: const EdgeInsets.all(5.0),
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //             color: Colors.blue,
                //             borderRadius: BorderRadius.circular(8.0)),
                //         child: Text(
                //           date.day.toString(),
                //           style: TextStyle(color: Colors.white),
                //         ),
                //     ),
                //   ),
                //   calendarController: _controller,
                // ),
              ),
            ],
          ),
        ));
  }
}