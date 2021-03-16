import 'package:flutter/material.dart';
import 'package:healthy_app/models/pie_data.dart';
import 'package:healthy_app/screens/home/settings_list.dart';
import 'package:healthy_app/services/auth.dart';
import 'package:healthy_app/screens/home/settings_list.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Progress extends StatefulWidget {

  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  final AuthService _auth = AuthService();

  List<charts.Series<PieData, String>> _pieData;

  void initState() {
     super.initState();
    _pieData = List<charts.Series<PieData, String>>();
  }

  generateData(){
    var piedata = [
      new PieData('Work', 35.8),
      new PieData('Eat', 8.3),
      new PieData('Commute', 10.8),
      new PieData('TV', 15.6),
      new PieData('Sleep', 19.2),
      new PieData('Other', 10.3),
    ];

    _pieData.add(
      charts.Series(
        domainFn: (PieData data, _) => data.activity,
        measureFn: (PieData data, _) => data.time,
        id: 'Time spent',
        data: piedata,
        labelAccessorFn: (PieData row, _) => '${row.activity}',
      ),
    );
    return _pieData;
  }

  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  Text("Calories"),
                  Container(
                  width: 175,
                  height: 175,
                    child: charts.PieChart(
                    generateData(),
                    animate: true,
                    animationDuration: Duration(seconds: 1),
                    defaultRenderer: new charts.ArcRendererConfig(
                      arcWidth: 100,
                      arcRendererDecorators: [
                        new charts.ArcLabelDecorator(
                            labelPosition: charts.ArcLabelPosition.inside)
                      ],
                    ),
                  ),
                )],
              ),
            ),
            Container(
              width: 175,
              height: 100,
            ),
          ],
        ),
    );
  }
}