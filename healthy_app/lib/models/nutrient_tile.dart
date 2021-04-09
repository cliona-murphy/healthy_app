import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'nutrient.dart';

class NutrientTile extends StatefulWidget {
  final Nutrient tile;
  // final String tileContent;
  // final bool complete;
  //
  NutrientTile({ this.tile });

  @override
  _NutrientTileState createState() => _NutrientTileState();
}

class _NutrientTileState extends State<NutrientTile> {
  bool isSelected = true;

  void initState(){
    super.initState();
    setState(() {
      isSelected = widget.tile.complete;
    });
    print(isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: CheckboxListTile(
          title: Text(widget.tile.tileContent,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
          subtitle: Text("Take at ${widget.tile.complete}"),
          secondary: IconButton(
            icon: Icon(Icons.edit),
            onPressed: (){
              //editItem(context, widget.medication.medicineName, widget.medication.timeToTake);
              setState(() {
              });
            },
          ),
          value: isSelected,
          onChanged: (bool newValue) {
            setState(() {
              print(isSelected);
              //updateDatabase(newValue, widget.medication.medicineName);
              isSelected = newValue;
            });
          },
        ),
      ),
    );
  }
}
