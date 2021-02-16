import 'package:flutter/material.dart';
import 'package:healthy_app/services/auth.dart';
import 'package:healthy_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FoodDiary extends StatefulWidget {

  @override
  _FoodDiaryState createState() => _FoodDiaryState();
}

class _FoodDiaryState extends State<FoodDiary> {

  final DatabaseService _db = DatabaseService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  String userId = "";

  TextEditingController customController = TextEditingController();
  TextEditingController calorieController = TextEditingController();

  bool foodLogged = false;

  Future <String> onContainerTapped(BuildContext context, String mealId){
    print("Here");
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
          title: Text("What did you eat?"),
          content: Container(
            height: 100,
            child : SingleChildScrollView(
              child: Column(
                children: [
                  //Text("Food name"),
                  TextField(
                    controller: customController,
                    decoration: InputDecoration(
                      hintText: "food name",
                    ),
                  ),
                  TextField(
                    controller: calorieController,
                    decoration: InputDecoration(
                      hintText: "calories",
                    ),
                  ),
                ],
              ),
            ),
          ),
        actions: <Widget> [
          MaterialButton(
              elevation: 5.0,
              child: Text("Submit"),
              onPressed: () {
                //Navigator.of(context).pop(customController.text.toString());
                foodLogged = true;
               // print("foodLogged true");
                updateDatabase(customController.text, int.parse(calorieController.text), mealId);
                customController.clear();
                calorieController.clear();
                Navigator.pop(context);
              },
          ),
        ],
      );
   });
  }

  updateDatabase(String name, int calories, String mealId) async{
    userId = await getUid();
    if(userId != ""){
      DatabaseService(uid: userId).addNewFood(name, calories, mealId);
      //error is because not using instance of databaseService to handle operation
      DatabaseService(uid: userId).getFoods(mealId);
      //displayFoods(mealId);
      //userId = "";
    }
  }

   Future<String> getUid() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    print(uid);
    return uid;
  }

  displayFoods(String mealId) async{
    final FirebaseUser user = await auth.currentUser();
    Firestore.instance.collection("entries").getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        Firestore.instance
            .collection("entries")
            .document(result.documentID)
            .collection("foods")
            .where("mealId", isEqualTo: mealId)
            .getDocuments()
            .then((querySnapshot) {
          querySnapshot.documents.forEach((result) {
            final foodList = List<String>();
            //foodList.add(result.data);
            print(result.data);
          });
        });
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: new Container (
          padding: const EdgeInsets.all(30.0),
          color: Colors.white,
          child: new Container(
              child: new Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 0.0)),
                    GestureDetector(
                      onTap: () {
                        print("here - Text on tap");
                        },
                        child: Text('Breakfast',
                        style: new TextStyle(
                        color: Colors.blue, fontSize: 20.0),),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        Container(
                          width: 300,
                          height: 60,
                          child: InkWell(
                            onTap: () {
                              onContainerTapped(context, "breakfast");
                            },
                              child: foodLogged ? Text('') :
                                 Text('Enter what you ate for breakfast'),
                            ),
                             // child: Text('Enter what you ate for breakfast')),
                            // child: TextField(
                            //   decoration: InputDecoration(
                            //     labelText: "What did you eat for breakfast?"
                            //   ),
                            // ),
                         // ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)
                          ),
                               //get food entered for breakfast from db and display here
                        ),
                        Padding(padding: EdgeInsets.only(top: 20.0)),
                        Text('Lunch',
                          style: new TextStyle(
                              color: Colors.blue, fontSize: 20.0),),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        TextField(
                          decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(),
                              ),
                              hintText: 'What did you eat for lunch?'
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20.0)),
                        Text('Dinner',
                          style: new TextStyle(
                              color: Colors.blue, fontSize: 20.0),),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        TextField(
                          decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(),
                              ),
                              hintText: 'What did you eat for dinner?'
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20.0)),
                        Text('Snacks',
                          style: new TextStyle(
                              color: Colors.blue, fontSize: 20.0),),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        TextField(
                          decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(),
                              ),
                              hintText: 'What snacks did you have?'
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20.0)),
                        Text('Water',
                          style: new TextStyle(
                              color: Colors.blue, fontSize: 20.0),),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        GestureDetector(
                          child: TextField(
                            decoration: InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                ),
                                fillColor: Colors.blue, //not working for some reason
                                hintText: 'How much water did you drink?'
                            ),
                          ),
                    )
                  ]),
          ),
        ),
      ),
    );
  }
}
