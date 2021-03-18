import 'package:flutter/material.dart';

class FacilityChips extends StatelessWidget {
  FacilityChips(this.amenities);
  final List amenities;
  @override
  Widget build(BuildContext context) { 
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 5),
      height: 40,      
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: amenities.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: 5,bottom: 5, right: 10),
            child: RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('${amenities[index]}'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              onPressed: () {},

            ),
          );         
        },
      ),
    );
  }
}
