import 'package:flutter/material.dart';
import 'package:nepsal/models/historyModel.dart';

class HistoryScreen extends StatelessWidget {
  final List<History> histories = [
    History(
      arenaName: 'Imadol Futsal Arena',
      date: 'Sun, May 31st',
      time: '7:00 -8:00',
      price: 'Rs. 1200',
    ),
    History(
      arenaName: 'Skyfall Futsal Arena',
      date: 'Sun, Apr 22nd',
      time: '10:00 -12:00',
      price: 'Rs. 800',
    ),
    History(
      arenaName: 'Sunshuine Futsal Arena',
      date: 'Sun, Feb 23rd',
      time: '6:00 -7:00',
      price: 'Rs. 700',
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        // centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
            itemCount: histories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: FlutterLogo(),
                    title: Text(
                      histories[index].arenaName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            histories[index].date,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            histories[index].time,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Text(
                      histories[index].price,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
