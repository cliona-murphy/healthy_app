import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_app/models/medication.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  //collection reference
  final CollectionReference settingsCollection = Firestore.instance.collection('settings');

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

  Future addMedication(String medName, String time) async {
    return await Firestore.instance.collection('users')
        .document(uid)
        .collection('medications')
        .document(medName)
        .setData({
      'medicationName': medName,
      'timeToTake': time,
    });
  }

  Stream<List<Medication>> get medications {
    return  Firestore.instance
        .collection("users")
        .document(uid)
        .collection('medications')
        .snapshots()
        .map(medicationListFromSnapshot);
  }

  List<Medication> medicationListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Medication(
        medicineName: doc.data['medicationName'] ?? '',
        timeToTake: doc.data['timeToTake'] ?? '',
      );
    }).toList();
  }
}