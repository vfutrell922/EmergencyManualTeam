// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.
import 'package:emergencymanual/icons.dart';

import 'package:flutter/material.dart';
import 'model/chart.dart';
import 'db/handbookdb_handler.dart';

class GridLayout {
  final String title;

  GridLayout({required this.title});
}

class QuickLinksPage extends StatefulWidget {
  @override
  _QuickLinksState createState() => _QuickLinksState();
}

class _QuickLinksState extends State<QuickLinksPage> {
  late List<Chart> _charts;

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCharts(),
        builder: (ctx, snapshot) {
          // Checking if future is resolved
          if (snapshot.connectionState == ConnectionState.done) {
            // If we got an error
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: TextStyle(fontSize: 18),
                ),
              );

              // if we got our data
            } else if (snapshot.hasData) {
              return QuickLinks(context);
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Future<List<Chart>> getCharts() async {
    List<Chart> charts = await HandbookDatabase.instance.getQuickLinkCharts();
    _charts = charts;
    return charts;
  }

  List<GridLayout> iconOptions() {
    return _charts.map((chart) => GridLayout(title: chart.Name)).toList();
  }

  Widget QuickLinks(BuildContext context) {
    return new GridView.custom(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: (2 / 2),
        ),
        childrenDelegate: SliverChildListDelegate(
          iconOptions()
              .map((data) => GestureDetector(
                  onTap: () {},
                  child: GestureDetector(
                    child: Container(
                        padding: const EdgeInsets.all(16),
                        color: Colors.teal[200],
                        child: Center(
                          child: Column(
                            children: [
                              Text(data.title,
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.black),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        )),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => ImageDialog(data.title));
                    },
                  )))
              .toList(),
        ));
  }

  // Widget getPhoto(String name) {
  //   return
  // }

  Widget ImageDialog(String chartname) {
    return Dialog(
      child: Container(
        width: 400,
        height: 500,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage(
                    'assets/images/pulselessDeterminationCriteria.png'),
                fit: BoxFit.cover)),
      ),
    );
  }
}
