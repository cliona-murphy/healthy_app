import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
    final foods = Provider.of<List<Food>>(context);
    foods.forEach((food) {
      print(food.name.toString());
    });

    return ListView.builder(
      itemCount: foods.length,
      itemBuilder: (context, index) {
        return Text(foods[index].name.toString());
      },
    );
  }
}
