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

    if(foods != null){
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
      return CircularProgressIndicator();
    }
  }
}
