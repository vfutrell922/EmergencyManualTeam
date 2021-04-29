import 'package:flutter/material.dart';

class ProtocolPage extends StatefulWidget {
  @override
  _ProtocolState createState() => _ProtocolState();
}

class _ProtocolState extends State<ProtocolPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cardiac Arrest'),
        centerTitle: true,
        backgroundColor: Color(0xFFFFFF),
      ),
      body: Scaffold(
        appBar: _buildRoleBar(context),
        body: Container(
          child: _buildProtocolInfoList(),
        ),
      ),
    );
  }

  Widget _buildProtocolInfoList() {
    return new Center(child: new Column());
  }

  Widget _buildRoleBar(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double roleButtonWidth = (screenWidth - (screenWidth * .1)) / 5;
    double roleButtonHeight = roleButtonWidth * 0.5;
    return new Row(
      children: <Widget>[
        new SizedBox(
          width: roleButtonWidth,
          height: roleButtonHeight,
          child: new ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.yellow,
              onPrimary: Colors.black,
            ),
            onPressed: () => print("General Pressed"),
            child: new Text("General"),
          ),
        ),
        new SizedBox(
          width: roleButtonWidth,
          height: roleButtonHeight,
          child: new ElevatedButton(
            onPressed: () => print("EMT Pressed"),
            child: new Text("EMT"),
          ),
        ),
        new SizedBox(
          width: roleButtonWidth,
          height: roleButtonHeight,
          child: new ElevatedButton(
            onPressed: () => print("AEMT Pressed"),
            child: new Text("AEMT"),
          ),
        ),
        new SizedBox(
          width: roleButtonWidth,
          height: roleButtonHeight,
          child: new ElevatedButton(
            onPressed: () => print("Paramedic Pressed"),
            child: new Text("Paramedic"),
          ),
        ),
        new SizedBox(
          width: roleButtonWidth,
          height: roleButtonHeight,
          child: new ElevatedButton(
            onPressed: () => print("Charts Pressed"),
            child: new Text("Charts"),
          ),
        ),
      ],
    );
  }
}
