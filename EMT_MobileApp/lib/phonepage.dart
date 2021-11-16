// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.
import 'package:flutter/material.dart';
import 'model/phonenumber.dart';
import 'logbar.dart';

import 'package:url_launcher/url_launcher.dart';

import 'db/handbookdb_handler.dart';

FloatingActionButton PhoneButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new PhonePage()),
      );
    },
    child: const Icon(Icons.local_phone),
    backgroundColor: Colors.red,
  );
}

class PhonePage extends StatefulWidget {
  @override
  _PhonePageState createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  List<PhoneNumber> phonenums = [];

  @override
  void initState() {
    this._getPhoneNumbers();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: LogBar(),
      appBar: AppBar(
        title: Text('Hospital Phone Numbers'),
        centerTitle: true,
        backgroundColor: Color(0xFFFFFF),
      ),
      body: Container(
        child: _buildPhoneNumsList(),
      ),
    );
  }

  void _getPhoneNumbers() async {
    List<PhoneNumber> tempList =
        await HandbookDatabase.instance.readAllPhoneNumbers();

    setState(() {
      phonenums = tempList;
    });
  }

  Widget _buildPhoneNumsList() {
    return ListView.builder(
      itemCount: phonenums.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            child: new GestureDetector(
          onTap: () {
            launch("tel://" + phonenums[index].numberString);
          },
          child: Container(
              height: 45.0,
              decoration: BoxDecoration(
                color: Color.fromRGBO(172, 206, 242, 1),
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: new Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                          child: Text(
                            phonenums[index].hospitalName,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 30.0),
                          ),
                        ),
                        new GestureDetector(
                          onTap: () {
                            launch("tel://" + phonenums[index].numberString);
                          },
                          child: new Container(
                              margin: const EdgeInsets.all(0.0),
                              child: new Icon(
                                Icons.local_phone,
                                color: Colors.red,
                                size: 30.0,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 0.0),
                    child: Container(
                      height: 5.0,
                    ),
                  ),
                ],
              )),
        ));
      },
    );
  }
}
