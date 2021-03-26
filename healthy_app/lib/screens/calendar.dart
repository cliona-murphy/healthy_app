import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:healthy_app/screens/home/home.dart' as HomePage;

class CalendarView extends StatefulWidget {

  final String title;
  CalendarView({ this.title}) ;

  @override
  _CalendarViewState createState() => new _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  CalendarController _controller = CalendarController();
  String selectedDay = "";
  //HomePage.newDateSelected = false;

  void initState() {
    super.initState();
    //_controller = CalendarController();
  }

  //EventList<Event> _markedDateMap = new EventList<Event>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        // appBar: new AppBar(
        //   title: new Text("Calendar"),
        // ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 30.0)),
              Container(
                child: TableCalendar(
                  calendarController: _controller,
                  availableCalendarFormats: const {
                    CalendarFormat.week: 'Two Weeks',
                    CalendarFormat.month: 'Week',
                    CalendarFormat.twoWeeks: "Month",
                  },
                  startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: (date, events,e) {
                    //print(date.)
                     // HomePage.newDateSelected;
                      selectedDay = "${date.day}/${date.month}/${date.year}";
                      print("${date.day}/${date.month}/${date.year}");
                      print(date.toUtc());
                    },
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context, selectedDay);
                    },
                    child: Text("Go back"),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}