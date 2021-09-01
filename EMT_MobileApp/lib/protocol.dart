import 'package:flutter/material.dart';
import 'httpservice.dart';
import 'postmodel.dart';

class ProtocolPage extends StatefulWidget {
  @override
  _ProtocolState createState() => _ProtocolState();
}

class _ProtocolState extends State<ProtocolPage> {
  final HttpService httpService = HttpService();
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 5,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Color(0xFFFFFF),
              title: Text("Cardiac Arrest"),
              bottom: new TabBar(
                isScrollable: true,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                tabs: [
                  new Container(
                    color: Colors.yellow,
                    child: new Tab(
                      child: Text("General"),
                    ),
                  ),
                  new Container(
                    color: Colors.blue,
                    child: new Tab(
                      child: Text("EMT"),
                    ),
                  ),
                  new Container(
                    color: Colors.green,
                    child: new Tab(
                      child: Text("AEMT"),
                    ),
                  ),
                  new Container(
                    color: Colors.red,
                    child: new Tab(
                      child: Text("Paramedic"),
                    ),
                  ),
                  new Container(
                    color: Colors.grey,
                    child: new Tab(
                      child: Text("Charts"),
                    ),
                  ),
                ],
              )),
          body: FutureBuilder(
            future: httpService.getPosts(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                String posts = snapshot.data;
                return ListView(children: <Widget>[
                  Text(posts),
                ]);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}
