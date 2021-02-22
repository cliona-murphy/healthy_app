import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_app/models/food.dart';
import 'package:healthy_app/models/settings.dart';

class DatabaseService {

  final String uid;
  //final String documentId;
  var docId;
  var documentId;
  DatabaseService ({this.uid});

  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference settingsCollection = Firestore.instance.collection('settings');
  final CollectionReference entryCollection = Firestore.instance.collection('entries');
  final CollectionReference foodCollection = Firestore.instance.collection('foods');

  //final String documentId = setDocId('21/2/2021');

  //creating new document in user collection for user with id = uid
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
      'entryDate': date,
    });
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
    //'AxmGT2evOzSr2qiQnKsmGQyrjxr1
  // 'oaSKwZqXVblVvfDhhvT2'
  //docId causing problem here
    Stream<List<Food>> get foods {
    //String _doc1Id = '';
      String test = 'test string';
      Firestore.instance.collection("users")
          .document(uid)
          .collection("entries")
          .where('entryDate', isEqualTo: "22/2/2021")
          .getDocuments()
          .then((querySnapshot) {
        print(querySnapshot.documents);
        querySnapshot.documents.forEach((result) {
          print("document id from within food stream getter is = " + result.documentID.toString());
          String _doc1Id = result.documentID.toString();
          setDocumentId(_doc1Id);
        });
      });
      //print("docId from within food stream function = " + documentId.toString());
      print("user id from within food stream is " + documentId.toString());
    return Firestore.instance
        .collection("users")
        .document(uid)
        .collection('entries')
        .document('ux5etQTwKicCkI3SpXzD')
        .collection('foods')
        //.where('mealId', isEqualTo: mealId)
        .snapshots()
      .map(foodListFromSnapshot);
    }
    //food list from a snapshot
  setDocumentId(String docId) {
    print("Set doc id called");
    print("doc Id passed in is: " + docId);
    documentId = docId;
    print("document Id is set to: " + documentId.toString());
  }
  List<Food> foodListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Food(
        foodName: doc.data['foodName'] ?? '',
        calories: doc.data['calories'] ?? 0,
        mealId: doc.data['mealId'] ?? '',
      );
    }).toList();
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

  // setDocId(String date) async{
  //   print("setDocId called");
  //   print("date:" + date);
  //   await Firestore.instance.collection("users")
  //       .document(uid)
  //       .collection("entries")
  //       .where('entryDate', isEqualTo: "21/2/2021")
  //       .getDocuments()
  //       .then((querySnapshot) {
  //     print(querySnapshot.documents);
  //     querySnapshot.documents.forEach((result) {
  //       docId = result.documentID;
  //     });
  //   });
  //   print("docId = " + docId.toString());
  // }
  String setDocId(String date){
    print("setDocId called");
    print("date:" + date);
    Firestore.instance.collection("users")
        .document(uid)
        .collection("entries")
        .where('entryDate', isEqualTo: "21/2/2021")
        .getDocuments()
        .then((querySnapshot) {
      print(querySnapshot.documents);
      querySnapshot.documents.forEach((result) {
        docId = result.documentID;
      });
    });
    print("docId = " + docId.toString());
    return docId;
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
              foodName: result.data['foodName'],
              calories: result.data['calories'],
              mealId: result.data['mealId'])
          );
        });
      });
    });
    return foods;
  }
}