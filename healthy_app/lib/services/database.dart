import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_app/models/food.dart';
import 'package:healthy_app/models/settings.dart';

class DatabaseService {

  final String uid;
  var docId;
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
  Future addNewFood(String foodName, int calories, String mealId, String date) async {
    //creating a new document in collection for user with id = uid
    await Firestore.instance.collection("users")
        .document(uid)
        .collection("entries")
        .where('entryDate', isEqualTo: date)
        .getDocuments()
        .then((querySnapshot) {
          print(querySnapshot.documents);
          querySnapshot.documents.forEach((result) {
            docId = result.documentID;
           });
        });
    print(docId); //keep in for testing
    return await Firestore
        .instance
        .collection('users')
        .document(uid)
        .collection('entries')
        .document(docId)
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
            .collection("users")
            .document(uid)
            .collection("entries")
            .document(docId)
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
    return  Firestore.instance
        .collection("users")
        .document('AxmGT2evOzSr2qiQnKsmGQyrjxr1')
        .collection('entries')
        .document('oaSKwZqXVblVvfDhhvT2')
        .collection('foods')
        //.where('mealId', isEqualTo: mealId)
        .snapshots()
      .map(foodListFromSnapshot);
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

  Stream<QuerySnapshot> get foodsSnapshot {
    Firestore.instance
        .collection("users")
        .document(uid)
        .collection('entries')
        .document(getDocId())
        .collection('foods')
    //.where('mealId', isEqualTo: mealId)
        .snapshots();
  }

  Stream<List<Settings>> get userSettings {
    return  Firestore.instance
        .collection("settings")
        //.document(uid)
        .snapshots()
        .map(settingsListFromSnapshot);
  }

  List<Settings> settingsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Settings(
        kcalInput: doc.data['kcalIntakeTarget'] ?? 0,
        kcalOutput: doc.data['kcalOutputTarget'] ?? 0,
        targetWater: doc.data['waterIntakeTarget'] ?? 0.0,
      );
    }).toList();
  }

  String getDocId(){
    return docId;
  }
}