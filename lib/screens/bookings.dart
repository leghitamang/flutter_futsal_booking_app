import 'package:flutter/material.dart';
import 'package:nepsal/models/bookingModel.dart';

class BookingsScreen extends StatelessWidget {
  final List<Bookings> bookings = [
    Bookings(
      arenaName: 'Furious Futsal Arena',
      date: 'Mon, June 8th',
      time: '6:15 - 7:15',
      price: 'Rs.900',
    ),
    Bookings(
      arenaName: 'Ventroma Futsal Arena',
      date: 'Sun, June 15th',
      time: '9:00 - 10:00',
      price: 'Rs.1200',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    bookings[index].date,
                    style: TextStyle(color: Colors.black45),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        backgroundImage: NetworkImage('http://192.168.0.5/uploads/arenas/1591188459.jpg'),
                      ),
                      title: Text(
                        bookings[index].arenaName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              bookings[index].date,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              bookings[index].time,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: RaisedButton(
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
