import 'package:flutter/material.dart';
import 'package:healthy_app/models/food.dart';

class FoodTile extends StatelessWidget {

  final Food food;
  FoodTile({ this.food});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Text("here")
      // child: Card(
      //   margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      //   child: ListTile(
      //     leading: CircleAvatar(
      //       radius: 5,
      //       backgroundColor: Colors.blue,
      //     ),
      //     title: Text(food.name),
      //     subtitle: Text("${food.calories.toString()} calories"),
      //   ),
      // ),
    );
  }
}
