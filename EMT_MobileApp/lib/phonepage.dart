// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.
import 'package:flutter/material.dart';
import 'model/phonenumber.dart';
import 'logbar.dart';

import 'package:url_launcher/url_launcher.dart';

import 'db/handbookdb_handler.dart';

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
    debugPrint("phone numbers: " + tempList.toString());

    setState(() {
      phonenums = tempList;
    });
  }

  Widget PhoneNumberEntry(PhoneNumber pn) {
    return new ListTile(
      title: Text(pn.hospitalName),
      onTap: () {
        launch("tel://" + pn.numberString);
      },
    );
  }

  Widget _buildPhoneNumsList() {
    return ListView.builder(
      itemCount: phonenums.length,
      itemBuilder: (BuildContext context, int index) {
        return PhoneNumberEntry(phonenums[index]);
      },
    );
  }
}
