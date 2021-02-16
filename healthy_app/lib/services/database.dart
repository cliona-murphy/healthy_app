import 'package:cloud_firestore/cloud_firestore.dart';

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
    return await entryCollection.document(uid).setData({
      'date': date,
    });
  }
  Future addNewFood(String foodName, int calories, String mealId) async {
    //creating a new document in collection for user with id = uid
    // return await entryCollection.document(uid).foodCollection.document.add({
    //   'foodName': foodName,
    //   'calories': calories,
    // });
    return await Firestore
        .instance
        .collection('entries')
        .document(uid)
        .collection(
        "foods")
        .add({
      'foodName': foodName,
      'calories': calories,
      'mealId' : mealId,
    });
  }
  //need to make reference to uid in this function
    getFoods(mealId){
      entryCollection.getDocuments().then((querySnapshot) {
       // querySnapshot.documents.forEach((result) {
          Firestore.instance
              .collection("entries")
              //.document(result.documentID) - foods being printed twice for some reason - because its looping through all entries so printing the data as many times as there are entries
              .document(uid)
              .collection("foods")
              .where("mealId", isEqualTo: mealId)
              .getDocuments()
              .then((querySnapshot) {
            querySnapshot.documents.forEach((result) {
              print(result.data);
            });
          });
        });
     // });
    }
  //get foods Stream
  // Stream<QuerySnapshot> get foods(String mealId) {
  //   Firestore.instance.collection("entries").getDocuments().then((querySnapshot) {
  //     querySnapshot.documents.forEach((result) {
  //       Firestore.instance
  //           .collection("entries")
  //           .document(result.documentID)
  //           .collection("foods")
  //           .where("mealId", isEqualTo: mealId)
  //           .getDocuments()
  //           .then((querySnapshot) {
  //         querySnapshot.documents.forEach((result) {
  //           final foodList = List<String>();
  //           //foodList.add(result.data);
  //           print(result.data);
  //         });
  //       });
  //     });
  //   });
  //   //return result;
  // }
}