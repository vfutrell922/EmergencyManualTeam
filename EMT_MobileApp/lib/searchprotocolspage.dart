// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.
import 'package:flutter/material.dart';
import 'protocolpage.dart';
import 'logbar.dart';
import 'phonepage.dart';

import 'db/handbookdb_handler.dart';

//reference for basic search app
// https://github.com/ahmed-alzahrani/Flutter_Search_Example/blob/master/lib/main.dart

class SearchProtocolsPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchProtocolsPage> {
  // controls the text label we use as a search bar
  final TextEditingController _filter = new TextEditingController();

  String _searchText = "";

  List guidelines = [];

  List protocols = []; // protocols from the database

  List filteredProtocols = []; // protocols filtered from the search

  Icon _searchIcon = new Icon(Icons.search);

  Widget _appBarTitle = new Text('Search');

  @override
  void initState() {
    this._getProtocols();
    super.initState();
  }

  _SearchPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredProtocols = protocols;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: PhoneButton(context),
      bottomNavigationBar: LogBar(),
      appBar: AppBar(
        title: Text('Protocol Glossary'),
        centerTitle: true,
        backgroundColor: Color(0xFFFFFF),
      ),
      body: Scaffold(
        appBar: _buildSearchBar(context),
        body: Container(
          child: _buildResultsList(),
        ),
      ),
    );
  }

  AppBar _buildSearchBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      backgroundColor: Color(0xFFFFFF),
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  Widget _buildResultsList() {
    if (_searchText.isNotEmpty) {
      List tempList = [];
      for (int i = 0; i < filteredProtocols.length; i++) {
        if (filteredProtocols[i]
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredProtocols[i]);
        }
      }
      filteredProtocols = tempList;
    }
    return ListView.builder(
      itemCount: protocols == null ? 0 : filteredProtocols.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            child: new GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                        new ProtocolPage(filteredProtocols[index])));
          },
          child: Container(
              height: 45.0,
              decoration: BoxDecoration(
                color: Color.fromRGBO(172, 206, 242, 1),
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
                            filteredProtocols[index],
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15.0),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0))),
                        ),
                        new GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new ProtocolPage(
                                        filteredProtocols[index])));
                          },
                          child: new Container(
                              margin: const EdgeInsets.all(0.0),
                              child: new Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
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

  void _getProtocols() async {
    List tempList =
        await HandbookDatabase.instance.readNonRepeatingProtocolNames();
    debugPrint(tempList.toString());

    setState(() {
      protocols = tempList;
      filteredProtocols = protocols;
    });
  }

  void _searchPressed() {
    setState(() {
      // If the search button has been pressed
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        // listen for input
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('');
        filteredProtocols = protocols;
        _filter.clear();
      }
    });
  }
}
