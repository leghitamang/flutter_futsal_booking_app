import 'package:flutter/material.dart';
import 'package:nepsal/components/bookAppBar.dart';
import 'package:nepsal/components/bookingAlert.dart';
import 'package:nepsal/components/timeSlotModal.dart';
import 'package:nepsal/models/arenaModel.dart';
import 'package:nepsal/screens/cofirmbook.dart';
import '../components/facilityChips.dart';
import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;

class BookScreen extends StatefulWidget {
  final Arena arena;
  BookScreen(this.arena);
  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  void initState() {
    super.initState();
    // getTimeSlots();
  }

  getTimeSlots() async {
    try {} catch (e) {
      print(e);
    }
  }

  DateTime _date;
  String selectedTime;

  selectTime(String timeSelected) {
    setState(() {
      selectedTime = timeSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BookAppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: FractionallySizedBox(
              child: Stack(
                children: <Widget>[
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3), BlendMode.srcATop),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'http://192.168.0.5/uploads/arenas/${widget.arena.arenaImage}'),
                              // Utility.url +'/uploads/arenas/'+ widget.arena.arenaImage),
                          // 'https://brucepulmanpark.com/wp-content/uploads/2017/12/ella.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 65,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.arena.arenaName,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 15,
                              ),
                              Text(widget.arena.location,
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                          SizedBox(height: 5),
                          Text('Rs.${widget.arena.price}',
                              style: TextStyle(color: Colors.white)),
                          // Text('${widget.arena.description}',
                          //     style: TextStyle(color: Colors.white)),
                        ],
                      )),
                ],
              ),
              heightFactor: 0.4,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40)),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('     ' + widget.arena.description),
                        ),
                        SizedBox(height: 10),
                        FacilityChips(Arena.amenities),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 45,
                                width: 150,
                                child: RaisedButton(
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  child: Text(
                                    _date == null
                                        ? 'Choose Date'
                                        : DateFormat('yyyy-MMMM-dd')
                                            .format(_date),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    showDatePicker(
                                      context: (context),
                                      initialDate: _date == null
                                          ? DateTime.now()
                                          : _date,
                                      firstDate: DateTime.now()
                                          .subtract(Duration(days: 1)),
                                      lastDate:
                                          DateTime.now().add(Duration(days: 9)),
                                    ).then((date) {
                                      setState(() {
                                        _date = date;
                                      });
                                    });
                                  },
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: 45,
                                width: 150,
                                child: RaisedButton(
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  child: Text(
                                    selectedTime == null
                                        ? 'Choose Time'
                                        : selectedTime,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () async {
                                    print("$selectedTime");
                                    getTimeSlots();
                                    var time = await showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        context: (context),
                                        builder: (context) => TimeSlotModal());
                                    setState(() {
                                      selectedTime = time;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          height: 45,
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.green,
                            textColor: Colors.white,
                            child: Text('Proceed'),
                            onPressed: () {
                              if (_date == null || selectedTime == null) {
                                showDialog(
                                  context: context,
                                  builder: (_) =>
                                      Alert('Error', 'Invalid Date or Time'),
                                );
                              } else {
                                print(widget.arena);
                                print(_date);
                                print(selectedTime);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ConfirmBookScreen(
                                          widget.arena, _date, selectedTime),
                                    ));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              heightFactor: 0.65,
            ),
          ),
        ],
      ),
    );
  }
}
