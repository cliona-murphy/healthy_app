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
    selectedDay = getCurrentDate();
    //_controller = CalendarController();
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
        Navigator.pushNamedAndRemoveUntil(context,
            "/second",
              (r) => false,
              arguments: {
              "date": selectedDay});
      },
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

    // show the dialog
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
              //Padding(padding: EdgeInsets.only(top: 30.0)),
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
                      showAlertDialog(context);
                     // Navigator.pop(context, selectedDay);
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