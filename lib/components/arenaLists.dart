import 'package:flutter/material.dart';
// import 'package:nepsal/models/arenaModel.dart';
import 'package:nepsal/screens/book.dart';
import 'package:nepsal/utility.dart';

class ArenaList extends StatelessWidget {
  final arenas;
  ArenaList(this.arenas); 
  @override
  Widget build(BuildContext context) {
    print(arenas);
    double deviceHeight = MediaQuery.of(context).size.height;
    return ListView.builder(
      itemCount: arenas.length,
      itemBuilder: (BuildContext context, index) {
        var location = arenas[index].location.split(',');
        print(location);
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookScreen(arenas[index])));
          },
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            elevation: 4,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  height: deviceHeight * 0.30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'http://192.168.0.5/uploads/arenas/${arenas[index].arenaImage}'),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  height: deviceHeight * 0.08,
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          
                          '${arenas[index].arenaName}',
                          style: TextStyle(color: Colors.white)
                        ),
                      ),                  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    location[0],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            )),
                          ),
                          Text(
                            'Price: Rs.${arenas[index].price}',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
