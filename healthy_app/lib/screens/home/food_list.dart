import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_app/models/food.dart';
import 'package:provider/provider.dart';
import 'package:healthy_app/screens/home/food_tile.dart';

class FoodList extends StatefulWidget {
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {
    bool foodsNull = false;
    final foods = Provider.of<List<Food>>(context) ?? [];

    //if(foods != null){
    if(foods.isNotEmpty){
      print("foods list is not null");
      print("length of list = " + foods.length.toString());
      return ListView.builder(
        //scrollDirection: Axis.horizontal,
        itemCount: foods.length,
        itemBuilder: (context, index) {
          return FoodTile(food: foods[index]);
          //return Text("${foods[index].foodName.toString()} ${foods[index].calories.toString()} calories");
        },
      );
    } else {
      print("foods list is null");
      //return Text("What did you eat for breakfast?");
      return Container(
        height: 80,
        width: 300,
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 15),
        child: Text('What did you eat for breakfast?',
          textAlign: TextAlign.center,
          style: new TextStyle(
              color: Colors.grey, fontSize: 15.0),
        ),
      );
    }
  }
}
