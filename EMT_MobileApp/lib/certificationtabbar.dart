import 'package:flutter/material.dart';
import 'model/protocol.dart';
import 'model/chart.dart';
import 'model/medication.dart';
import 'logbar.dart';
import 'phonepage.dart';
import 'meddrawer.dart';
import 'package:flutter_html/flutter_html.dart';

class CertificationTabBar extends StatefulWidget {
  final String protocolname;

  final List<Protocol> protocols;
  final List<Chart> charts;
  final List<Medication> medications;

  CertificationTabBar(@required this.protocolname, @required this.protocols,
      @required this.charts, @required this.medications);

  @override
  _CertificationTabBarState createState() => _CertificationTabBarState(
      protocolname: protocolname,
      protocols: protocols,
      charts: charts,
      medications: medications);
}

class _CertificationTabBarState extends State<CertificationTabBar>
    with SingleTickerProviderStateMixin {
  final String protocolname;
  final List<Protocol> protocols;
  final List<Chart> charts;
  final List<Medication> medications;

  _CertificationTabBarState(
      {required this.protocolname,
      required this.protocols,
      required this.charts,
      required this.medications});

  late TabController _controller;
  late List<TabData> _tabData;
  late List<Tab> _tabs = [];
  late List<Widget> _tabViews = [];
  late Color _activeColor;

  @override
  void initState() {
    super.initState();
    _tabData = [
      TabData(title: 'General', certification: 3, color: Colors.yellow),
      TabData(title: 'EMT', certification: 0, color: Colors.blue),
      TabData(title: 'AEMT', certification: 1, color: Colors.green),
      TabData(title: 'Paramedic', certification: 2, color: Colors.red),
      TabData(title: 'Charts', certification: -1, color: Colors.grey),
    ];
    _activeColor = _tabData.first.color;
    _tabData.forEach((data) {
      final tab = Tab(
        child: Container(
          constraints: BoxConstraints.expand(),
          color: data.color,
          child: Center(
            child: Text(data.title),
          ),
        ),
      );
      _tabs.add(tab);

      final widget = new Scaffold(
          endDrawer: MedDrawer(data.certification, protocols, medications),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: data.color,
            foregroundColor: Colors.black,
            title: Text(
              data.title,
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: new Container(
            child: new SingleChildScrollView(
              scrollDirection: Axis.vertical, //.horizontal
              child: findViewWithCertification(data.certification),
            ),
          ));
      _tabViews.add(widget);
    });
    _controller = TabController(vsync: this, length: _tabData.length)
      ..addListener(() {
        setState(() {
          _activeColor = _tabData[_controller.index].color;
        });
      });
  }

  /// Parses the rich text information of the certification's protocol and gathers it into a single string.
  Widget findViewWithCertification(int certification) {
    if (certification == -1) {
      return new Column(
        children: <Widget>[
          ...displayAllCharts(),
        ],
      );
    }
    String protocol = "";
    protocols.forEach((element) {
      if (element.Certification == certification) {
        if (element.PatientType == 0) {
          protocol += "<p><b>Adult</b></p>";
        } else if (element.PatientType == 1) {
          protocol += "<p><b>Pediatric</b></p>";
        } else if (element.PatientType == 2) {
          protocol += "<p><b>All Ages</b></p>";
        }
        if (element.TreatmentPlan != Null) {
          protocol += ("<p><b>Treatment Plan</b></p>" +
              element.TreatmentPlan.toString() +
              "<p></p>");
        }
        if (element.OtherInformation != Null) {
          protocol += ("<p><b>Other Information</b></p>" +
              element.OtherInformation.toString() +
              "<p></p>");
        }
      }
    });
    return Html(data: protocol);
  }

  List displayAllCharts() {
    List<Widget> ret = charts
        .map((chart) => GestureDetector(
            onTap: () {},
            child: GestureDetector(
              child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.teal[200],
                  child: Center(
                    child: Column(
                      children: [
                        Image.memory(chart.Photo),
                      ],
                    ),
                  )),
              onTap: () {
                showDialog(
                    context: context, builder: (_) => ImageDialog(chart));
              },
            )))
        .toList();
    return ret;
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: _activeColor),
      child: Scaffold(
        floatingActionButton: PhoneButton(context),
        bottomNavigationBar: LogBar(),
        appBar: AppBar(
          title: Text(protocolname),
          bottom: TabBar(
            indicatorColor: _activeColor,
            labelPadding: EdgeInsets.zero,
            controller: _controller,
            tabs: _tabs,
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: _tabViews,
        ),
      ),
    );
  }
}

class TabData {
  TabData(
      {required this.title, required this.certification, required this.color});

  final String title;
  final int certification;
  final Color color;
}
