import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  //collection reference
  final CollectionReference settingsCollection = Firestore.instance.collection('settings');
  final CollectionReference foodCollection = Firestore.instance.collection('foods');
  final CollectionReference entryCollection = Firestore.instance.collection('entries');

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
  Future addNewFood(String foodName, int calories) async {
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
    });
  }

  //get foods Stream
  Stream<QuerySnapshot> get foods {
    return foodCollection.snapshots();
  }
}