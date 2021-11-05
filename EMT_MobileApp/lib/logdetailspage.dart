// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.

import 'package:flutter/material.dart';
import 'package:emergencymanual/icons.dart';
import 'db/logdb_handler.dart';
import 'model/log.dart';
import 'logbar.dart';

class LogDetailsPage extends StatefulWidget {
  final Log curLog;
  LogDetailsPage({required this.curLog});

  @override
  _LogDetailsState createState() => _LogDetailsState(curLog: curLog);
}

List details = [];

class _LogDetailsState extends State<LogDetailsPage> {
  final Log curLog;
  _LogDetailsState({required this.curLog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Run Number: ${curLog.runNum}'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Delete Log',
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => _deleteDialog(context),
                );
              })
        ],
        backgroundColor: Color(0xFFFFFF),
      ),
      body: Center(
        child: _buildDetails(context),

        // child: new Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: <Widget>[
        //       new Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           new Text("Date Performed: March 10, 2021"),
        //         ],
        //       )
        //     ]),
      ),
      bottomNavigationBar: LogBar(),
    );
  }

  Widget _buildDetails(BuildContext context) {
    return FutureBuilder(
      // Future that needs to be resolved
      // inorder to display something on the Canvas
      future: LogDatabase.instance.additionalDataDecode(curLog.id!),
      builder: (ctx, snapshot) {
        // Checking if future is resolved or not
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
            // Extracting data from snapshot object
            final data = snapshot.data as List;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return new Card(
                    child: ListTile(
                  title: Row(children: <Widget>[
                    Text('Data ${data[index]}'),
                    IconButton(
                        icon: const Icon(Icons.delete),
                        tooltip: 'Delete Log',
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                _deleteDetailDialog(context, index),
                          );
                        })
                  ]),
                  subtitle: Text('Time: ${data[index][3]} '),
                ));
              },
            );
          }
        }

        // Displaying LoadingSpinner to indicate waiting state
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _deleteDialog(BuildContext context) {
    return new AlertDialog(
      title: Text('Delete Log?'),
      actions: <Widget>[
        new Text(
            "Are you sure you want to delete log for Run ${curLog.runNum}  ?"),
        TextButton(
          child: Text('CANCEL'),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        TextButton(
          child: Text('Delete Log',
              style: TextStyle(
                color: Colors.red,
              )),
          onPressed: () async {
            Navigator.pop(context);
            //Navigator.pop(context, true);
            await LogDatabase.instance.deleteLog(curLog.id!).then((value) {
              Navigator.pop(context, true);
            });
          },
        ),
      ],
    );
  }

//   Future<Widget> _deleteLogDialog(BuildContext context) async {
//     await Future.delayed(Duration(microseconds: 1));
// showDialog(
//         context: context,
//         builder: (BuildContext context) {
//     return new AlertDialog(
//       title: Text('Delete Log?'),
//       actions: <Widget>[
//         new Text(
//             "Are you sure you want to delete log for Run ${curLog.runNum}?"),
//         TextButton(
//           child: Text('CANCEL'),
//           onPressed: () {
//             setState(() {
//               Navigator.pop(context);
//             });
//           },
//         ),
//         TextButton(
//           child: Text('Delete Log',
//               style: TextStyle(
//                 color: Colors.red,
//               )),
//           onPressed: () async {
//             await LogDatabase.instance.deleteLog(curLog.id!);
//             // .then((_) {
//             //   setState(() {
//             //     Navigator.pop(context);
//             //   });
//             //   Navigator.pop(context, true); //send back to oldLogsPage
//             // });
//             Navigator.pop(context);
//             Navigator.pop(context, true); //send back to oldLogsPage
//           },
//         ),
//       ],
//     );
//   },);}

  Widget _deleteDetailDialog(BuildContext context, int index) {
    return new AlertDialog(
      title: Text('Delete this detail?'),
      actions: <Widget>[
        new Text("Are you sure you want to delete this detail?"),
        TextButton(
          child: Text('CANCEL'),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        TextButton(
          child: Text('Delete Detail',
              style: TextStyle(
                color: Colors.red,
              )),
          onPressed: () async {
            await LogDatabase.instance
                .additionalDataUpdate(
                    curLog.additionalData![index], false, index)
                .then((value) {
              setState(() {
                Navigator.pop(context);
              });
            });
          },
        ),
      ],
    );
  }
}
