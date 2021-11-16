// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.

import 'package:flutter/material.dart';
import 'homepage.dart';
import 'globals.dart' as globals;
import 'collection.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    globals.initNextLogID();
    return FutureBuilder(
        future: checkInternetAndUpdateHandbookdb(),
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
              return MaterialApp(
                title: 'Medic Manual',
                home: HomePage(),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
