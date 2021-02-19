import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_app/models/food.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference settingsCollection = Firestore.instance.collection('settings');
  final CollectionReference entryCollection = Firestore.instance.collection('entries');
  final CollectionReference foodCollection = Firestore.instance.collection('foods');

  //creating new document in user collection for user with id = uid
  //not currently used, maybe delete?
  Future addUser(String email) async {
    //creating a new document in collection for user with id = uid
    return await userCollection.document(uid).setData({
      'email': email,
    });
  }

  Future updateUserData(int kcalIntakeTarget, int kcalOutputTarget, double waterIntakeTarget) async {
    //creating a new document in collection for user with id = uid
    return await settingsCollection.document(uid).setData({
      'kcalIntakeTarget': kcalIntakeTarget,
      'kcalOutputTarget': kcalOutputTarget,
      'waterIntakeTarget': waterIntakeTarget,
    });
  }

  //get userSettings Stream
  Stream<QuerySnapshot> get settings {
    return settingsCollection.snapshots();
  }

  Future createNewEntry(String date) async {
    //creating a new document in collection for user with id = uid
    return await Firestore.instance.collection('users')
        .document(uid)
        .collection('entries')
        .add({
      //'name': "entry1",
      'entryDate': date,
    });
    // return await entryCollection.document(uid).setData({
    //   'date': date,
    // });
  }
  Future addNewFood(String foodName, int calories, String mealId) async {
    //creating a new document in collection for user with id = uid
    var dId;
    await Firestore.instance.collection("users")
        .document(uid)
        .collection("entries")
        .where('entryDate', isEqualTo: '19/2/2021')
        .getDocuments()
        .then((querySnapshot) {
          print(querySnapshot.documents);
          querySnapshot.documents.forEach((result) {
            dId = result.documentID;
           });
        });
    print(dId); //keep in for testing
    return await Firestore
        .instance
        .collection('users')
        .document(uid)
        .collection('entries')
        .document(dId)
        .collection('foods')
        .add({
      'foodName': foodName,
      'calories': calories,
      'mealId': mealId,
    });
  }
  //need to make reference to uid in this function
   List<Food> getFoods(mealId){
     List<Food> foods = new List<Food>();
    entryCollection.getDocuments().then((querySnapshot) {
        Firestore.instance
            .collection("entries")
            .document(uid)
            .collection("foods")
            .where("mealId", isEqualTo: mealId)
            .getDocuments()
            .then((querySnapshot) {
          querySnapshot.documents.forEach((result) {
            //make food object here
            foods.add(new Food(
                name: result.data['foodName'],
                calories: result.data['calories'],
                mealId: result.data['mealId'])
            );
          });
        });
      });
    return foods;
    }

    Stream<List<Food>> get foods {
    return entryCollection
        .document(uid)
        .collection('foods')
        //.where('mealId', isEqualTo: mealId)
        .snapshots()
      .map(foodListFromSnapshot);
    // return entryCollection.getDocuments().then((querySnapshot) {
    //   Firestore.instance
    //       .collection("entries")
    //       .document(uid)
    //       .collection("foods")
    //       .where("mealId", isEqualTo: mealId)
    //       .getDocuments()
    //       .then((querySnapshot) {
    //     querySnapshot.map(_foodListFromSnapshot);
    //     });
    //   });
    }
    //food list from a snapshot
  List<Food> foodListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Food(
        name: doc.data['name'] ?? '',
        calories: doc.data['calories'] ?? 0,
        mealId: doc.data['mealId'] ?? '',
      );
    }).toList();
  }
}