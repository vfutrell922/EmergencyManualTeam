// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.
import 'package:flutter/material.dart';
import 'protocol.dart';

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
        return new ListTile(
          title: Text(filteredProtocols[index]),
          onTap: () => {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new ProtocolPage())),
          },
        );
      },
    );
  }

  void _getProtocols() async {
    //TODO: Where we will actually fetch from the database
    //
    // creates a connection
//     String address = "3.135.224.240";
//     var conn = new SqlConnection(
//         "SERVER=localhost;Database=EMTManualContext;User ID=EMTManual;Password=password",
//         address);

// // open connection
//     await conn.open();

// // runs a query returning a single value
//     var namecount = await conn.queryValue("SELECT NAME FROM Protocol");

// // // runs a query returning a single row
// //     var myFirstCustomer =
// //         await conn.querySingle("SELECT name,age FROM Custormers");
// //     print(myFirstCustomer["name"]);

// // // runs a query returning all rows
// //     var customers = await conn.query("SELECT TOP 10 name,age FROM Custormers");
// //     for (var customer in customers) {
// //       print(customer["name"]);
// //     }

// // // execute a command, returning the number of rows affected
// //     var n = await conn.execute("UPDATE Customers SET age=0");
// //     print("zeroed $n customers");

// // disconnect
//     await conn.close();

    List tempList = [
      "General Patient Care",
      "Cardiac Arrest",
      "Medical Patient Care",
      "Trauma Field Triage and Transport",
      "Appendix 1: EMS Medication Cards",
      "Laryngoscopy",
    ];

    setState(() {
      protocols = tempList;
      filteredProtocols = protocols;
    });
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
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
