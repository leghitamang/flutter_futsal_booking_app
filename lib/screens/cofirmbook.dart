import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepsal/components/bookingAlert.dart';
import 'package:nepsal/models/arenaModel.dart';

class ConfirmBookScreen extends StatelessWidget {
  final Arena arena;
  final selectedTime;
  final selectedDate;
  ConfirmBookScreen(this.arena, this.selectedDate, this.selectedTime);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Booking'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: 400,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            _buildDetails('Arena Name:', arena.arenaName),
            SizedBox(height: 10),
            _buildDetails(
                'Date:', DateFormat('yyyy-MMMM-dd').format(selectedDate)),
            SizedBox(height: 10),
            _buildDetails('Booking Time:', selectedTime),
            SizedBox(height: 10),
            _buildDetails('Price:', 'Rs.' + arena.price.toString()),
            SizedBox(height: 100),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 45,
                    // width: 200,
                    child: RaisedButton(
                        child: Text('Cancel'),
                        color: Colors.red,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Container(
                    height: 45,
                    // width: 200,
                    child: RaisedButton(
                      child: Text('Book'),
                      color: Colors.green,
                      textColor: Colors.white,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => Alert('Successful',
                              'Your Boooking Date: 9th June 2020, Time: 9:15 - 10:15'),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetails(name, value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
            child: Text(
          name,
          style: TextStyle(fontSize: 18),
        )),
        Expanded(
            child: Text(
          value,
          style: TextStyle(fontSize: 18),
        )),
      ],
    );
  }
}
