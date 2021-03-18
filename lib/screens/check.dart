import 'package:flutter/material.dart';
// import 'package:nepsal/models/arenaModel.dart';

class Check extends StatelessWidget {
  //  final List<Arena> arenas = [
  //   Arena(
  //       arenaName: 'Ventroma Futsal Arena',
  //       description: 'It is one the of best futal in town.',
  //       location: 'Boudha,Kathmandu',
  //       price: '900',
  //       amenities: ['Shower','Parking','Locker Room','Shower','Parking','Locker Room'],
  //       arenaImage:
  //           'https://s3-us-west-1.amazonaws.com/urbanpitch/wp-content/uploads/2017/07/18020207/1-Adidas_Tango-2632.jpg'),
  //   Arena(
  //       arenaName: 'Heiseinberg Futsal Arena',
  //       description: 'It is one the of best futal in town.',
  //       location: 'Imadol,Kathmandu',
  //       price: '800',
  //       amenities: ['Shower','Parking','Locker'],
  //       arenaImage:
  //           'https://www.sportsfloorsparquet.com/wp-content/uploads/2016/09/removable-sports-floor-parquet-futsal-world-cup-colobia-2016-dalla-riva-09.jpg'),
  //   Arena(
  //       arenaName: 'Bigbang Futsal Arena',
  //       description: 'It is one the of best futal in town.',
  //       location: 'Koteshwor,Kathmandu',
  //       price: '700',
  //       amenities: ['Shower','Parking','Locker'],
  //       arenaImage:
  //           'https://img.fifa.com/image/upload/t_l1/rihhx0hpcbhhxjowkemc.jpg'),
  //   Arena(
  //       arenaName: 'SuperNova Futsal Arena',
  //       description: 'It is one the of best futal in town.',
  //       location: 'Baneshwor,Kathmandu',
  //       price: '600',
  //       amenities: ['Shower','Parking','Locker'],
  //       arenaImage:
  //           'https://happeningindtla.com/wp-content/uploads/2017/09/17834857_1893392224278783_7059575312509006608_o.jpg'),
  //   Arena(
  //       arenaName: 'Hantun Futsal Arena',
  //       description: 'It is one the of best futal in town.',
  //       location: 'Kalanki,Kathmandu',
  //       price: '1000',
  //       amenities: ['Shower','Parking','Locker'],
  //       arenaImage:
  //           'https://static.wixstatic.com/media/eef0d2_f4db83ef0a5a4cbebd46ad537b00d257.jpg'),
  //   Arena(
  //       arenaName: 'Passion Futsal Arena',
  //       description: 'It is one the of best futal in town.',
  //       location: 'Sitapaila,Kathmandu',
  //       price: '1100',
  //       amenities: ['Shower','Parking','Locker'],
  //       arenaImage:
  //           'https://secureservercdn.net/184.168.47.225/666.f04.myftpupload.com/wp-content/uploads/2015/12/Adidas_IMG_2319.jpg'),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: FractionallySizedBox(
              heightFactor: 0.4,
              child: Container(
                // color: Colors.red,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://s3-us-west-1.amazonaws.com/urbanpitch/wp-content/uploads/2017/07/18020207/1-Adidas_Tango-2632.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
                heightFactor: 0.65,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildChips('Parking'),
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          height: 45,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: RaisedButton(
                            child: Text('Book', style: TextStyle(fontSize: 16)),
                            color: Colors.blue,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            onPressed: () {},
                          ),
                        ))
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildChips(String amenities) {
    return Chip(
      label: Text(amenities),
      backgroundColor: Colors.blue,
      labelStyle: TextStyle(color: Colors.white),
      shadowColor: Colors.black45,
    );
  }
}
