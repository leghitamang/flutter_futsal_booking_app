import 'package:flutter/material.dart';

class TimeSlotModal extends StatelessWidget {    
  final List timeSlots = [
    '6:15 - 7:15',
    '7:15 - 8:15',
    '8:15 - 9:15',
    '9:15 - 10:15',
    '10:15 - 11:15',
    '11:15 - 12:15',
    '12:15 - 13:15',
    '13:15 - 14:15',
    '14:15 - 15:15',
    '15:15 - 16:15',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: EdgeInsets.all(10),
      child: GridView.count(
        crossAxisCount: 3,
        primary: false,
        children: List.generate(
          timeSlots.length,
          (index) {
            return OutlineButton(
              child: Text(
                timeSlots[index],
                style: TextStyle(fontSize: 15),
              ),
              onPressed: (){
                Navigator.pop(context, timeSlots[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
