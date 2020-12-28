import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  //collection reference
  final CollectionReference userSettingsCollection = Firestore.instance.collection('userSettings');

  Future updateUserData(int kcalIntakeTarget, int kcalOutputTarget, double waterIntakeTarget) async {
    //creating a new document in collection for user with id = uid
    return await userSettingsCollection.document(uid).setData({
      'kcalIntakeTarget': kcalIntakeTarget,
      'kcalOutputTarget': kcalOutputTarget,
      'waterIntakeTarget': waterIntakeTarget,
    });
  }

  //get userSettings Stream
  Stream<QuerySnapshot> get userSettings {
    return userSettingsCollection.snapshots();
  }

}