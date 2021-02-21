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
    // milk

    foods.forEach((food) {
      print(food.name.toString());
    });

    if(foods != null){
      print("foods list isn't null");
      print("length of list = " + foods.length.toString());
      print(foods[0].calories.toString());
      return ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          return Text(foods[index].calories.toString());
        },
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}
