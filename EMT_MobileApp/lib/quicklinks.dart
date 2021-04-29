import 'package:flutter/material.dart';

class QuickLinksPage extends StatefulWidget {
  @override
  _QuickLinksState createState() => _QuickLinksState();
}

class _QuickLinksState extends State<QuickLinksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Emergency Manual'),
          centerTitle: true,
          backgroundColor: Color(0xFFFFFF),
        ),
        body: QuickLinksPanel());
  }
}

class QuickLinksPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          child:
              Image.asset('assets/images/health1.png', height: 300, width: 300),
          color: Colors.teal[200],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child:
              Image.asset('assets/images/health2.png', height: 300, width: 300),
          color: Colors.teal[200],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child:
              Image.asset('assets/images/health3.png', height: 300, width: 300),
          color: Colors.teal[200],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child:
              Image.asset('assets/images/health4.png', height: 300, width: 300),
          color: Colors.teal[200],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child:
              Image.asset('assets/images/health5.png', height: 300, width: 300),
          color: Colors.teal[200],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child:
              Image.asset('assets/images/health6.png', height: 300, width: 300),
          color: Colors.teal[200],
        ),
      ],
    );
  }
}
