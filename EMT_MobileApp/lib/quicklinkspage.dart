// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.
import 'package:emergencymanual/icons.dart';
import 'package:emergencymanual/logdetailspage.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'model/chart.dart';
import 'db/handbookdb_handler.dart';
import 'logbar.dart';
import 'phonepage.dart';

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
        //Collect the charts first
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

  /// Gets the charts that have the quick link flag from the db
  Future<List<Chart>> getCharts() async {
    List<Chart> charts = await HandbookDatabase.instance.getQuickLinkCharts();
    _charts = charts;
    return charts;
  }

  Widget QuickLinks(BuildContext context) {
    return Scaffold(
        floatingActionButton: PhoneButton(context),
        bottomNavigationBar: LogBar(),
        appBar: AppBar(
          title: Text('Quick Links'),
          centerTitle: true,
          backgroundColor: Color(0xFFFFFF),
        ),
        body: new GridView.custom(
            padding: EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: (2 / 2),
            ),
            childrenDelegate: SliverChildListDelegate(
              _charts
                  .map((chart) => GestureDetector(
                      onTap: () {},
                      child: GestureDetector(
                        child: Container(
                            padding: const EdgeInsets.all(16),
                            color: Colors.teal[200],
                            child: Center(
                              child: Column(
                                children: [
                                  Text(chart.Name,
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.black),
                                      textAlign: TextAlign.center)
                                ],
                              ),
                            )),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) => ImageDialog(chart));
                        },
                      )))
                  .toList(),
            )));
  }

  /// The displayed chart as a pop up dialog.
  Widget ImageDialog(Chart chart) {
    TransformationController _controller = TransformationController();
    return AlertDialog(title: Text(chart.Name), actions: <Widget>[
      new Center(
        child: InteractiveViewer(
          boundaryMargin: EdgeInsets.all(20.0),
          maxScale: 5.0,
          transformationController: _controller,
          onInteractionEnd: (value) {
            _controller.value = Matrix4.identity();
          },
          child: Image.memory(chart.Photo),
        ),
      )
    ]);
  }
}
