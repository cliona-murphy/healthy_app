import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:healthy_app/models/arguments.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:healthy_app/screens/home/home.dart' as HomePage;
import 'package:healthy_app/shared/globals.dart' as globals;

class CalendarView extends StatefulWidget {

  final String title;
  CalendarView({ this.title}) ;

  @override
  _CalendarViewState createState() => new _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  CalendarController _controller = CalendarController();
  String selectedDay = "";
  DateTime newDate;
  bool newDateSet = false;

  void initState() {
    super.initState();
    selectedDay = getCurrentDate();
    print("selected date = " + globals.newDate.toString());
    // _controller.setFocusedDay(globals.newDate);
    // DateTime testDate = globals.newDate;
    // if (globals.newDateSelected)
    //   {
    //     //var date = globals.
    //     //_controller.setFocusedDay(globals.newDate);
    //     setInitialDate(testDate);
    //   }
    //_controller.setSelectedDay(globals.newDate);
    //Day(globals.newDate);
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   _controller.setFocusedDay(globals.newDate);
    //_controller.s
    // });
  }

  setInitialDate(DateTime date){
    _controller.setFocusedDay(date);
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {
        setState(() {
          globals.selectedDate = selectedDay;
          globals.newDateSelected = true;
          if(globals.newDate == DateTime.now()) print("agh");

          //
          //print("new date = ${globals.newDate.day}/${globals.newDate.month}/${globals.newDate.year}");
          //print("agh" + newDate.toString());
          globals.newDate = newDate;
          print("aghhh" + globals.newDate.toString());
          newDateSet = true;
        });
        Navigator.pushNamedAndRemoveUntil(context,
            "/second",
              (r) => false,
              );
        }
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Would you like to view data you entered on ${selectedDay}?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String getCurrentDate(){
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.day}/${dateParse.month}/${dateParse.year}";
    return formattedDate;
  }

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
                  initialSelectedDay: globals.newDate,
                  availableCalendarFormats: const {
                    CalendarFormat.week: 'Two Weeks',
                    CalendarFormat.month: 'Week',
                    CalendarFormat.twoWeeks: "Month",
                  },
                  startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: (date, events,e) {
                    //print(date.)
                     // HomePage.newDateSelected;
                      newDate = date;
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
                      showAlertDialog(context);
                    },
                    child: Text("Select date"),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}