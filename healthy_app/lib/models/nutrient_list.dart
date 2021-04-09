import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_app/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:healthy_app/models/nutrient.dart';
import 'medication.dart';
import 'medication_checklist.dart';
import 'nutrient_tile.dart';

class NutrientList extends StatefulWidget {
  @override
  _NutrientListState createState() => _NutrientListState();
}

class _NutrientListState extends State<NutrientList> {
  bool loading = true;

  void initState(){
    super.initState();
    updateBoolean();
  }

  updateBoolean(){
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final nutrientTiles = Provider.of<List<Nutrient>>(context) ?? [];
    //final loggedMedications = Provider.of<List<MedicationChecklist>>(context) ?? [];

    if(nutrientTiles.isNotEmpty){
      print(nutrientTiles);

      return loading ? Loading() : ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: nutrientTiles.length,
        itemBuilder: (context, index) {
          return NutrientTile(tile: nutrientTiles[index]);
        },
      );
    } else {
      return Container(
        height: 80,
        width: 300,
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: Text('You have not added anything to this list yet',
          textAlign: TextAlign.center,
          style: new TextStyle(
              color: Colors.blue, fontSize: 20.0),
        ),
      );
    }
  }

  checkIfTaken(Medication medication, List<MedicationChecklist> loggedMedications) {}
  }

