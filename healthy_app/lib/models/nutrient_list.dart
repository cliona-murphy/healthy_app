// import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';
//
// import 'medication.dart';
// import 'medication_checklist.dart';
//
// class NutrientList extends StatefulWidget {
//   @override
//   _NutrientListState createState() => _NutrientListState();
// }
//
// class _NutrientListState extends State<NutrientList> {
//   @override
//   Widget build(BuildContext context) {
//     final medications = Provider.of<List<Medication>>(context) ?? [];
//     final loggedMedications = Provider.of<List<MedicationChecklist>>(context) ?? [];
//
//     if(medications.isNotEmpty){
//       print(medications);
//
//       return ListView.builder(
//         shrinkWrap: true,
//         physics: BouncingScrollPhysics(),
//         itemCount: medications.length,
//         itemBuilder: (context, index) {
//           return NutrientTile(medication: medications[index], taken: checkIfTaken(medications[index], loggedMedications));
//         },
//       );
//     } else {
//       return loading ? Loading() : Container(
//         height: 80,
//         width: 300,
//         padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
//         child: Text('You have not added anything to this list yet',
//           textAlign: TextAlign.center,
//           style: new TextStyle(
//               color: Colors.blue, fontSize: 20.0),
//         ),
//       );
//     }
//   }
//   }
// }
