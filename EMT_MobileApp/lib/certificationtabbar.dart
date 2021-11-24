import 'package:flutter/material.dart';

class CertificationTabBar extends StatefulWidget {
  createState() => _CertificationTabBarState();
}

class _CertificationTabBarState extends State<CertificationTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late List<TabData> _tabData;
  late List<Tab> _tabs = [];
  late List<Widget> _tabViews = [];
  late Color _activeColor;

  @override
  void initState() {
    super.initState();
    _tabData = [
      TabData(title: 'General', color: Colors.yellow),
      TabData(title: 'EMT', color: Colors.blue),
      TabData(title: 'AEMT', color: Colors.green),
      TabData(title: 'Paramedic', color: Colors.red),
      TabData(title: 'Charts', color: Colors.grey),
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

      final widget = Scaffold(backgroundColor: data.color);
      _tabViews.add(widget);
    });
    _controller = TabController(vsync: this, length: _tabData.length)
      ..addListener(() {
        setState(() {
          _activeColor = _tabData[_controller.index].color;
        });
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: _activeColor),
      child: Scaffold(
        backgroundColor: _activeColor,
        appBar: AppBar(
          title: Text('Multi Colored Tab Bar'),
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
  TabData({required this.title, required this.color});

  final String title;
  final Color color;
}
