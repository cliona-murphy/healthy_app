import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_app/models/food.dart';
import 'package:healthy_app/services/database.dart';

class FoodTile extends StatefulWidget {

  final Food food;
  FoodTile({ this.food});

  @override
  _FoodTileState createState() => _FoodTileState();
}

class _FoodTileState extends State<FoodTile> {
  TextEditingController nameController;
  TextEditingController calorieController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    nameController = new TextEditingController(text: widget.food.foodName);
  }


  Future<String> getUserid() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    return uid;
  }

  updateDetails(String foodName, String newFoodName, int calories) async {
    String userId = await getUserid();
    DatabaseService(uid: userId).updateFoodDetails(foodName, newFoodName, calories);
  }

  deleteFood(String foodName) async {
    String userId = await getUserid();
    DatabaseService(uid: userId).deleteFood(foodName);
  }

  Future<String> editItem(BuildContext context, String foodName, int calories) {
    print("Edit item called");
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Edit details here:"),
        content: Container(
          height: 100,
          child : SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: foodName,
                  ),
                ),
                Container(
                  // child: Column(
                  //   children: [
                  //     InkWell(
                  //       //onTap: () => _selectTime(context)
                  //     ),
                  child: TextField(
                    controller: calorieController,
                    decoration: InputDecoration(
                      hintText: calories.toString(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget> [
          IconButton(
            icon: Icon(Icons.delete),
            //elevation: 5.0,
            color: Colors.red,
            onPressed: () {
              deleteFood(widget.food.foodName);
              nameController.clear();
              calorieController.clear();
              Navigator.pop(context);
            },
          ),
          MaterialButton(
            elevation: 5.0,
            child: Text("Update"),
            onPressed: () {
              updateDetails(widget.food.foodName, nameController.text, int.parse(calorieController.text));
              nameController.clear();
              calorieController.clear();
              Navigator.pop(context);
            },
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
          icon: Icon(Icons.edit),
          onPressed: (){
            editItem(context, widget.food.foodName, widget.food.calories);
            setState(() {
            });
          },
        ),
        title: Text(widget.food.foodName),
        subtitle: Text("${widget.food.calories.toString()} calories"),
        onTap: () {
          //print(temp[index]);
      });
  }
}
