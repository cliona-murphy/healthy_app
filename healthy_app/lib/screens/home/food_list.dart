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

    final foods = Provider.of<List<Food>>(context) ?? [];
    return ListView.builder(
      itemCount: foods.length,
      itemBuilder: (context, index) {
        return FoodTile(food: foods[index]);
      },
    );
  }
}
